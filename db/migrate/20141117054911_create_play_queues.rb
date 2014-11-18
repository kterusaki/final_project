class CreatePlayQueues < ActiveRecord::Migration
  def change
    create_table :play_queues do |t|

      t.timestamps
    end
  end
end
