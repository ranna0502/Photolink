class AddTimeToActivityPoints < ActiveRecord::Migration[6.1]
  def change
    add_column :activity_points, :time, :time
    add_column :activity_points, :date, :date
  end
end
