# controller.rb
class Controller

  def initialize
    @view = View.new
    @commands = ["team_selfishness", "league_selfishness", "point_leaders", "rebound_leaders", "assist_leaders", "team_leaders", "team_stars", "team_weighted_efficiency", "league_weighted_efficiency", "player_weighted_efficiency", "players"]
  end

  def launch
    if @commands.include?(@view.command)
      eval(@view.command)
    else
      @view.help
    end
  end

  def team_selfishness
    selfish_array = @view.team.players.sort_by {|player| player.selfishness_rate}
    selected_selfish_array = selfish_array[-(@view.top)..-1]
    attributes = ["selfishness_rate", "position", "points", "rebounds"]
    @view.print(selected_selfish_array.reverse, attributes)
  end

  def league_selfishness
    selfish_array = Player.all.sort_by {|player| player.selfishness_rate}.select { |player| player.position != "Center" }
    selected_selfish_array = selfish_array[-(@view.top)..-1]
    attributes = ["selfishness_rate", "position", "in_team", "points", "rebounds"]
    @view.print(selected_selfish_array.reverse, attributes)
  end

  def point_leaders
    attributes = ["points"]
    @view.print(get_point_leaders.reverse, attributes)
  end

  def get_point_leaders
    point_leaders_ar = @view.team.players.sort_by { |player| player.points.to_i }[-(@view.top)..-1]
  end

  def rebound_leaders
    attributes = ["rebounds"]
    @view.print(get_rebound_leaders.reverse, attributes)
  end

  def get_rebound_leaders
    rebound_leaders_ar = @view.team.players.sort_by { |player| player.rebounds.to_i }[-(@view.top)..-1]
  end

  def assist_leaders
    attributes = ["assists"]
    @view.print(get_assist_leaders.reverse, attributes)
  end

  def get_assist_leaders
   assists_leaders_ar = @view.team.players.sort_by { |player| player.assists.to_i }[-(@view.top)..-1]
  end

  def team_leaders
    puts
    puts "Point Leaders"
    point_leaders
    puts
    puts "Rebound Leaders"
    rebound_leaders
    puts
    puts "Assist Leaders"
    assist_leaders
  end

  def team_stars
    stars_ar = []
    get_point_leaders.each do |player|
      stars_ar << player if (get_rebound_leaders.include?(player) && get_assist_leaders.include?(player))
    end
    attributes = ["points", "rebounds", "assists"]
    @view.print(stars_ar.reverse, attributes)
  end

  def player_main_stats
    player_stats_array = []
    player_stats_array = @view.player
    attributes = ["gp", "points", "rebounds", "assists"]
    @view.print(player_stats_array, attributes)
  end

  def player_stats_offense
    off_player_stats_array = []
    off_player_stats_array = @view.player
    attributes = ["points", "oreb", "assists", "tov", "fgm", "fg3_pct", "ft_pct"]
    @view.print(off_player_stats_array, attributes)
  end

  def player_stats_defense
    off_player_stats_array = []
    off_player_stats_array = @view.player
    attributes = ["dreb", "stl", "pf"]
    @view.print(off_player_stats_array, attributes)
  end

  def team_weighted_efficiency
    efficient_players = @view.team.players.sort_by {|player|
      player.weighted_efficiency}
    selected_efficient_players = efficient_players[-(@view.top)..-1]
    attributes = ["weighted_efficiency", "points", "assists", "rebounds"]
    @view.print(selected_efficient_players.reverse, attributes)
  end

  def league_weighted_efficiency
    efficient_players = Player.all.sort_by {|player|
      player.weighted_efficiency}
    selected_efficient_players = efficient_players[-(@view.top)..-1]
    attributes = ["weighted_efficiency", "points", "assists", "rebounds"]
    @view.print(selected_efficient_players.reverse, attributes)
  end

  def player_weighted_efficiency
    attributes = ["weighted_efficiency", "points", "assists", "rebounds"]
    @view.print([@view.player], attributes)
  end

  def players
    attributes = ["gp", "points", "rebounds", "assists"]
    @view.print(@view.team.players, attributes)
  end

end

