class Organization < ApplicationRecord
  before_save :sanitize_urls

  has_many :memberships
  has_many :users, through: :memberships

  scope :approved, -> {where("approved = ?", true)}

  def sanitize_urls
    unless  self.website.blank? || self.website.include?('http://') || self.website.include?('https://')
        self.website = 'http://' + self.website
    end
  end

  validates :name,  presence: true
  validates :website,  presence: true
  validates :description,  presence: true
  validates :cause,  presence: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  def member
    User.find_by_id(Membership.where(organization_id: self).first.user_id)
  end
end
