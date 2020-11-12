class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.references :user
      t.references :room

      t.timestamps
    end

    add_foreign_key :entries, :users
    add_foreign_key :entries, :rooms
  end
end
