class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.integer :following_id, null: false
      t.integer :follower_id, null: false
      t.boolean :is_matched, 			    default: false

      t.timestamps
    end
  end
end
