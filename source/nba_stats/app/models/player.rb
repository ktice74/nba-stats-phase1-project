# player.rb
class Player < ActiveRecord::Base

  belongs_to :team

  def selfishness_rate
    if self.points > 180 && self.assists > 1
      selfishness_rate = 3*(1 - self.fg_pct.to_f/100 ) * (self.points.to_f / self.assists.to_f)
      selfishness_rate.round(2)
    else
      0
    end
  end

  def in_team
    self.team.name
  end

  def weighted_efficiency
    weighted_values = ((self.points) + (2.9 * self.assists) + (2.17 * self.rebounds)) / self.gp
    weighted_values.round(2)
  end

end
