class CreatePersonalMessages < ActiveRecord::Migration
  def change
    create_table :personal_messages do |t|
      t.text :body
      t.belongs_to :conversation, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
