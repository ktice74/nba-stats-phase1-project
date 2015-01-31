# team.rb
class Team < ActiveRecord::Base

  has_many :players

  def capitalized_team_name
    new_name = self.name
    first_letter = self.name[0]
    first_letter_upcase = first_letter.upcase
    new_name.sub(first_letter, first_letter_upcase)
  end

end
