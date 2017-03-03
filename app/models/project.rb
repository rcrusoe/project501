class Project < ApplicationRecord
  has_many :roles
  has_many :users, through: :roles

  has_many :conversations

  validates :title,  presence: true
  validates :description,  presence: true
  validates :category,  presence: true
  validates :problem,  presence: true
  validates :goal,  presence: true

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  def owner
    User.find_by_id(self.roles.where(:status => "Owner").first.user_id)
  end

  def applications
    self.roles.where(:status => "Applicant")
  end

  def applicants
    # todo: figure out how to replace with a join between project.applications and User on user_id = id
    applicant_ids = self.applications.to_a.map { |applicant| applicant.user_id }
    User.find(applicant_ids)
  end

  def organization
    Organization.find_by_id(Membership.where(user_id: self.owner).first.organization_id)
  end

  scope :recent, ->{ where("projects.created_at > ?", 1.week.ago) }


# SELECT * FROM Users INNER JOIN (SELECT * FROM role WHERE project_id = self.project_id AND status = Applicant) as t ON Users.id = t.user_id
#
#
#

end

