class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :author_id
      t.integer :receiver_id
      t.belongs_to :project, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :conversations, :author_id
    add_index :conversations, :receiver_id
  end
end
