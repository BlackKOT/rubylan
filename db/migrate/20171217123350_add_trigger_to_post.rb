class AddTriggerToPost < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE FUNCTION delete_taggables_from_posts() RETURNS trigger AS
      $delete_taggables_from_posts$
      BEGIN
        DELETE FROM taggables
        WHERE taggables.tagged_id=OLD.id AND taggables.tagged_type = 'Post';
        RETURN OLD;
      END;
      $delete_taggables_from_posts$ LANGUAGE plpgsql;

      CREATE TRIGGER delete_taggables
      BEFORE DELETE ON posts
      FOR EACH ROW
      EXECUTE PROCEDURE delete_taggables_from_posts();
  
      CREATE FUNCTION update_taggables_from_posts() RETURNS trigger AS
      $update_taggables_from_posts$
      BEGIN
        UPDATE taggables SET tagged_id=NEW.id
        WHERE taggables.tagged_id=OLD.id AND taggables.tagged_type = 'Post';
        RETURN NEW;
      END;
      $update_taggables_from_posts$ LANGUAGE plpgsql;

      CREATE TRIGGER update_taggables
      BEFORE UPDATE ON posts
      FOR EACH ROW
      EXECUTE PROCEDURE update_taggables_from_posts();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER   IF EXISTS delete_taggables ON posts;
      DROP FUNCTION  IF EXISTS delete_taggables_from_posts();
      DROP TRIGGER   IF EXISTS update_taggables ON posts;
      DROP FUNCTION  IF EXISTS update_taggables_from_posts();
    SQL
  end
end
