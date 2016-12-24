class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :website
      t.string :location
      t.text :description
      t.boolean :approved, :boolean, default: false

      t.timestamps null: false
    end
  end
end
