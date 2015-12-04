class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|

      t.string :name

      t.string :description

      t.string :url

      t.integer :category_id

      t.integer :user_id


      t.timestamps

    end

  end
end
