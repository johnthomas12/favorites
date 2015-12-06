class Favorite < ActiveRecord::Base
validates :name, :presence => true, :uniqueness => {:scope => :url}

belongs_to :category
belongs_to :user

has_many :ratings
has_many :comments
has_many :fans, :through => :ratings, :source => :user


end
