class Round < ActiveRecord::Base
  belongs_to :boat
  acts_as_list scope: :boat
  has_one :waypoint
  
  def to_s
    Waypoint.find(self.waypoint_id).to_s
  end
  
  def latlng
    waypoint = Waypoint.find(self.waypoint_id)
    [waypoint.latitude,waypoint.longitude]
  end
    
end