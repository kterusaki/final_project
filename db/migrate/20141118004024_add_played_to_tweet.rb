class AddPlayedToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :played, :boolean
  end
end
