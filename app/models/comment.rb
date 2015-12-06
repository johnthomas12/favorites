class Comment < ActiveRecord::Base

validates :user_id, :presence => true
validates :favorite_id, :presence => true
validates :body, :presence => true

belongs_to :favorite
belongs_to :user

end
