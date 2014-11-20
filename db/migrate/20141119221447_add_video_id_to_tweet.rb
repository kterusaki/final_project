class AddVideoIdToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :video_id, :string
  end
end
