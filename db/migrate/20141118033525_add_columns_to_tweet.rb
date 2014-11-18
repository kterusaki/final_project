class AddColumnsToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :twitter_id, :string
    add_column :tweets, :youtube_url, :string
  end
end
