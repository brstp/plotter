class Boat < ActiveRecord::Base
  has_many :rounds, -> { order("position ASC") }
  
  def add_round waypoint=nil
    unless waypoint.blank?
      round = Round.new
      round.boat = self
      round.waypoint_id = waypoint.id
      round.save!
    end
  end
  
  def start_location
    Waypoint.find(self.rounds.first.waypoint_id).name
  end
  
  def trip
    path = ''
    for round in self.rounds
      path += round.to_s + " "
    end
    return path.strip
  end
  
  def polyline
    self.rounds.map(&:latlng)
  end
end
