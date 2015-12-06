class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :presence => true, :uniqueness => true

  has_many :favorites
  has_many :categories
  has_many :comments
  has_many :ratings

  has_many :rated_favorites, :through => :ratings, :source => :favorite


end
