class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.belongs_to :author, foreign_key: true
      t.string :category
      t.datetime :dt
      t.float :position
      t.boolean :published

      t.timestamps
    end
  end
end
