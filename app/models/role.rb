class Role < ApplicationRecord
    belongs_to :project
    belongs_to :user

    scope :owner, -> { where('status = ?', "owner") }
    scope :applicant, -> { where('status = ?', "applicant") }
    scope :volunteer, -> { where('status = ?', "volunteer") }
end
