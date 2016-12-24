class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :status

      t.timestamps null: false
    end
  end
end
