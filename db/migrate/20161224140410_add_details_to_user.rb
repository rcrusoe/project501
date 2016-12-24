class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :tagline, :string
    add_column :users, :calendly_url, :string
    add_column :users, :catalant_url, :string
    add_column :users, :linkedin_url, :string
    add_column :users, :twitter_url, :string
    add_column :users, :medium_url, :string
    add_column :users, :github_url, :string
    add_column :users, :dribbble_url, :string
    add_column :users, :website_url, :string
    add_column :users, :approved, :boolean, default: false
  end
end
