# 20153001103800_create_players.rb

class CreateTeams < ActiveRecord::Migration

  def change
    create_table :teams do |t|
      t.string   :name

      t.timestamps
    end

  end
end
