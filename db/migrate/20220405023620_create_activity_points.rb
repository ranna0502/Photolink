class CreateActivityPoints < ActiveRecord::Migration[6.1]
  def change
    create_table :activity_points do |t|

      t.integer :user_id, null: false
      t.integer :person, null: false
      t.text :request, null: false
      t.string :address, null: false
      t.float :latitude
      t.float :longitude
      t.integer :activity_status, null: false


      t.timestamps
    end
  end
end
