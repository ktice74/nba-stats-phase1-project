# view.rb
# require_relative '../../config/application'

class View
README = <<eos
############# NBA STATS - Available Commands ###########################################
                 options: <top:10> <team:yourteam> <player:bestplayer>
   team_selfishness_rate: Who are the most selfish players in your team?
 league_selfishness_rate: Who are the most selfish players in the league?
           point_leaders: See the point leaders in your team
         rebound_leaders: See the rebound leaders in your team
          assist_leaders: See the assist leaders in your team
            team_leaders: All the team leaders, at once!
              team_stars: See the Team Stars! Team stars are the players who appear in all team leaders categories
eos

  attr_reader :command, :team, :top, :player

  def initialize
    @command = ARGV[0] || "readme"
    if @command != "readme"
      @arguments = ARGV[1..-1]
      get_team
      get_player
      get_top
    end
    # puts @command
    # puts @team
    # puts @player
    # puts @top
  end

  def help
    puts README
  end

  def get_team
    team_input = @arguments.find { |arg| arg.include?('team') }
    if team_input
      team_name = team_input.sub('team:', '')
      @team = Team.find_by_name(team_name) if Team.find_by_name(team_name)
    end
  end

  def get_player
    player_input = @arguments.find { |arg| arg.include?('player') }
    if player_input
      player_name = player_input.sub('player:', '')
      @player = Player.find_by_name(player_name) if Player.find_by_name(player_name)
    end
  end

  def get_top
    top_input = @arguments.find { |arg| arg.include?('top') }
    top_input ? @top = (top_input.sub('top:', '').to_i) : @top = 10
  end

  def print(players,attributes)
    if @team
      puts "#{@team.capitalized_team_name} --------------------------------------------------------------------"
    end
    players.each do |player|
      line = "Player: #{player.name} |"
      attributes.each do |attr|
        line += " #{attr}: #{player.send(attr)} |"
      end
      puts line
    end
  end

  def method_name

  end

end

