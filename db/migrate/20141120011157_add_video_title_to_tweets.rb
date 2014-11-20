class AddVideoTitleToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :vid_title, :string
  end
end
