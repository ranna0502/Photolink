class AddColumnsToActivityPoints < ActiveRecord::Migration[6.1]
  def change

    add_column :activity_points, :spot, :string
    add_column :activity_points, :prefecture, :string

  end
end
