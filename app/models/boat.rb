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
  
end
