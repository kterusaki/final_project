class AddForeignKeyToTweets < ActiveRecord::Migration
  def change
    add_reference :tweets, :identity, index: true
  end
end
