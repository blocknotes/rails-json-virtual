class AddRefToAuthors < ActiveRecord::Migration[5.1]
  def up
    execute <<~SQL
      ALTER TABLE authors ADD COLUMN ref VARCHAR(255) GENERATED ALWAYS AS
        (json_unquote(json_extract(`custom_data`,"$.a_ref"))) VIRTUAL AFTER custom_data
    SQL
    execute 'ALTER TABLE authors ADD KEY ref (ref)'
  end

  def down
    remove_column :authors, :ref
  end
end
