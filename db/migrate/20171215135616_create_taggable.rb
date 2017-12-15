class CreateTaggable < ActiveRecord::Migration[5.1]
  def change
    create_table :taggables do |t|
      t.string  :tagged_type, null: false
      t.integer :tagged_id,   null: false
      t.belongs_to :tag

      t.timestamps null: false
    end

  end
end
