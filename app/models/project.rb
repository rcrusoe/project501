class Project < ApplicationRecord
  has_many :roles
  has_many :users, through: :roles

  has_many :conversations

  validates :title,  presence: true
  validates :description,  presence: true
  validates :category,  presence: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
end

