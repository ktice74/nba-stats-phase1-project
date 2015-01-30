# player.rb
class Player < ActiveRecord::Base

  belongs_to :team

  def selfishness_rate
    if self.points > 180 && self.assists.to_i > 1
      self.points / self.assists.to_f
    else
      0
    end
  end

end
