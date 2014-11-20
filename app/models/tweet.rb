class Tweet < ActiveRecord::Base
	belongs_to :identity
	validates :twitter_id, presence: true
end
