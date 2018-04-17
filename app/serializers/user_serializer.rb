class UserSerializer < ActiveModel::Serializer
  attributes :id, :summonerName, :accountId, :profileIconId, :summonerLevel, :email, :summonerId
end
