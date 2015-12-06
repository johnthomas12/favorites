class Rating < ActiveRecord::Base

  validates :number, :numericality => {:only_integer=>true, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 10, :allow_blank => false}

  validates :user_id, :presence => true, :uniqueness => {:scope => :favorite}
  validates :favorite_id, :presence => true

  belongs_to :user
  belongs_to :favorite
end
