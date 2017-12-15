class CreatePost < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string     :name,           null: false
      t.belongs_to :category
      t.text       :body,           null: false
      t.text       :pretty_body,    null: false
      t.text       :pretty_preview, null: false

      t.timestamps null: false

      t.integer    :author_id
      t.string     :author_name
    end

    add_index :posts, :name
  end
end
