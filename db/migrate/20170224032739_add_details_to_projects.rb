class AddDetailsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :required_roles, :text
    add_column :projects, :problem, :text
    add_column :projects, :goal, :text
    add_column :projects, :status, :string
  end
end
