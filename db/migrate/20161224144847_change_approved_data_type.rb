class ChangeApprovedDataType < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :approved, :boolean, default: false
    end
  end
  def self.down
    change_table :users do |t|
      t.change :approved, :binary
    end
  end
end
