class User < ApplicationRecord
  validates :summonerName, presence: true

  has_many :user_matches

end
