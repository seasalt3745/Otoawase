class RenameRecordColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :record, :history
  end
end
