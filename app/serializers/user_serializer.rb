class UserSerializer < ActiveModel::Serializer
  attributes :summonerName, :accountId, :profileIconId, :summonerLevel, :email
end
