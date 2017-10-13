class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.virtual :full_name, type: :string, as: 'CONCAT(last_name," ",first_name)'
      t.json :custom_data, null: false
      # NOTE: ref column added later
      t.virtual :fiscal_code, type: :string
      t.virtual :upper_fiscal_code, type: :string, as: 'UPPER(fiscal_code)'
      t.virtual :length_fiscal_code, type: :integer, as: 'LENGTH(fiscal_code)', stored: true
      t.integer :age
      t.string :email

      t.timestamps
    end

    ## Create the indexed virtual column
    # reversible do |dir|
    #   dir.up do
    #     execute 'ALTER TABLE authors ADD COLUMN ref VARCHAR(255) GENERATED ALWAYS AS (json_unquote(json_extract(`custom_data`,"$.a_ref"))) VIRTUAL AFTER custom_data'
    #     execute 'ALTER TABLE authors ADD KEY ref (ref)'
    #   end
    # end
  end
end
