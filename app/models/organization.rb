class Organization < ActiveRecord::Base

  has_many :memberships
  has_many :users, through: :memberships

  scope :approved, -> {where("approved = ?", true)}
end
