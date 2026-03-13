class CreateChats < ActiveRecord::Migration[8.0]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uuid, null: false
      t.index :uuid, unique: true

      t.timestamps
    end
  end
end
