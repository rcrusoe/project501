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
end
