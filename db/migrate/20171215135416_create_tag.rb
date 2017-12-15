class CreateTag < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string     :name,    null: false
      t.integer    :counter, default: 0

      t.timestamps null: false
    end
  end
end
