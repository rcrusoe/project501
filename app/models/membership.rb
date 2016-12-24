class Membership < ActiveRecord::Base
  belongs_to :organizations
  belongs_to :user
end
