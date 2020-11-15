class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :user
      t.references :room
      t.string :message

      t.timestamps
    end

    add_foreign_key :entries, :users
    add_foreign_key :entries, :rooms
  end
end
