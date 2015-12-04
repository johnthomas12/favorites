class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|

      t.integer :number

      t.integer :user_id

      t.integer :favorite_id


      t.timestamps

    end

  end
end
