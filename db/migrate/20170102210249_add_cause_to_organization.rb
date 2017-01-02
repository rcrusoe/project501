class AddCauseToOrganization < ActiveRecord::Migration[5.0]
  def change
    add_column :organizations, :cause, :string
  end
end
