class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :sanitize_urls

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :memberships
  has_many :organizations, through: :memberships

  has_many :roles
  has_many :projects, through: :roles

  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'
  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'

  has_many :personal_messages, dependent: :destroy

  def name
    if first_name? && last_name?
      first_name + ' ' + last_name
    else
      email.split('@')[0]
    end
  end

  def sanitize_urls
    unless  self.calendly_url.blank? || self.calendly_url.include?('http://') || self.calendly_url.include?('https://')
      self.calendly_url = 'http://' + self.calendly_url
    end

    unless  self.catalant_url.blank? || self.catalant_url.include?('http://') || self.catalant_url.include?('https://')
      self.catalant_url = 'http://' + self.catalant_url
    end

    unless  self.linkedin_url.blank? || self.linkedin_url.include?('http://') || self.linkedin_url.include?('https://')
      self.linkedin_url = 'http://' + self.linkedin_url
    end

    unless  self.twitter_url.blank? || self.twitter_url.include?('http://') || self.twitter_url.include?('https://')
      self.twitter_url = 'http://' + self.twitter_url
    end

    unless  self.medium_url.blank? || self.medium_url.include?('http://') || self.medium_url.include?('https://')
      self.medium_url = 'http://' + self.medium_url
    end

    unless  self.github_url.blank? || self.github_url.include?('http://') || self.github_url.include?('https://')
      self.github_url = 'http://' + self.github_url
    end

    unless  self.dribbble_url.blank? || self.dribbble_url.include?('http://') || self.dribbble_url.include?('https://')
      self.dribbble_url = 'http://' + self.dribbble_url
    end

    unless  self.website_url.blank? || self.website_url.include?('http://') || self.website_url.include?('https://')
      self.website_url = 'http://' + self.website_url
    end
  end
end
