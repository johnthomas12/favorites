class Favorite < ActiveRecord::Base
validates :url, :presence => true

belongs_to :category
belongs_to :user

has_many :ratings
has_many :comments
has_many :fans, :through => :ratings, :source => :user



end
