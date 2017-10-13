class CreateDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :details do |t|
      t.belongs_to :author, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
