class Round < ActiveRecord::Base
  belongs_to :boat
  acts_as_list scope: :boat
  has_one :waypoint
end