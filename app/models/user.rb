class User < ApplicationRecord
  validates :summonerName, presence: true
end
