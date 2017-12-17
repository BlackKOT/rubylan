class CreatePost < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string     :name,           null: false
      t.belongs_to :category
      t.text       :body,           null: false
      t.text       :pretty_body,    null: false
      t.integer    :pretty_preview, null: false

      t.timestamps null: false
    end

    add_index :posts, :name

    add_foreign_key :posts, :categories, on_delete: :nullify, on_update: :cascade
  end
end
