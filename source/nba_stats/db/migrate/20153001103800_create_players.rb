# 20153001103800_create_players.rb

class CreatePlayers < ActiveRecord::Migration

  def change
    create_table :players do |t|
      t.string   :name
      t.string   :position
      t.integer  :number
      t.integer  :gp
      t.integer  :points
      t.integer  :rebounds
      t.integer  :assists
      t.float    :fg_pct
      t.integer  :fgm
      t.float    :fg3_pct
      t.float    :ft_pct
      t.integer  :oreb
      t.integer  :dreb
      t.integer  :stl
      t.integer  :tov
      t.integer  :pf
      t.integer  :team_id

      t.timestamps
    end

  end
end
