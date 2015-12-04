class Favorite < ActiveRecord::Base
validates :name, :presence => true, :uniqueness => {:scope => :url}

belongs_to :category, :class_name => "Category", :foreign_key => "category_id"
belongs_to :user

has_many :fans, :through => :likes, :source => :user



end
