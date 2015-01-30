require 'open-uri'
require 'nokogiri'

class Parser
  TEAMS = <<-eos
  Atlanta Hawks
  Boston Celtics
  Charlotte Bobcats
  Chicago Bulls
  Cleveland Cavaliers
  Denver Nuggets
  Detroit Pistons
  Golden State Warriors
  Houston Rockets
  Indiana Pacers
  LA Clippers
  LA Lakers
  Memphis Grizzlies
  Miami Heat
  Milwaukee Bucks
  Minnesota Timberwolves
  New Jersey Nets
  New Orleans Hornets
  New York Knicks
  Oklahoma City Thunder
  Orlando Magic
  Philadelphia Sixers
  Phoenix Suns
  Portland Trail Blazers
  Sacramento Kings
  San Antonio Spurs
  Toronto Raptors
  Utah Jazz
  Washington Wizards
  eos

  def initialize
    @teams_array = []
    TEAMS.split("\n").each do |team|
      @teams_array << team.split(" ")[-1].downcase
    end
  end

  def get_data_from_web
    @teams_array.each do |team|
      current_team = Team.create(name: team)
      Nokogiri::HTML(open("http://www.nba.com/#{team}/stats")).search('.stats-table.player-stats.season-totals.table.table-striped.table-bordered.sticky-enabled tbody tr').each do |row|
        Player.create(convert_to_player_args(row, current_team.id))
      end
    end
  end

  private

    def convert_to_player_args(table_row, team_id)
      {
       name: table_row.css('.playerName').text,
       position: table_row.css('.playerPosition').text,
       number: table_row.css('.playerNumber').text.to_i,
       gp: table_row.css('.gp').text.to_i,
       points: table_row.css('.pts').text.to_i,
       rebounds: table_row.css('.reb').text.to_i,
       assists: table_row.css('.ast').text.to_i,
       fg_pct: table_row.css('.fg_pct').text.to_f,
       fgm: table_row.css('.fgm').text.to_i,
       fg3_pct: table_row.css('.fg3_pct').text.to_f,
       ft_pct: table_row.css('.ft_pct').text.to_f,
       oreb: table_row.css('.oreb').text.to_i,
       dreb: table_row.css('.dreb').text.to_i,
       stl: table_row.css('.stl').text.to_i,
       tov: table_row.css('.tov').text.to_i,
       pf: table_row.css('.pf').text.to_i,
       team_id: team_id
     }
   end

end


