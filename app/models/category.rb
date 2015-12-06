class Category < ActiveRecord::Base
  validates :name, :presence => true

belongs_to :user
has_many :favorites

end
