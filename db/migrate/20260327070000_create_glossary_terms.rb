class CreateGlossaryTerms < ActiveRecord::Migration[8.0]
  def change
    create_table :glossary_terms, if_not_exists: true do |t|
      t.string :term, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_index :glossary_terms, :term, unique: true, if_not_exists: true
  end
end
