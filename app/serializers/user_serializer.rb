class UserSerializer < ActiveModel::Serializer
  attributes :summonerName, :accountId, :profileIconId, :summonerLevel
end
