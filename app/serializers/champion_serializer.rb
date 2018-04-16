class ChampionSerializer < ActiveModel::Serializer
  attributes :champ_id, :image_url, :nickname, :name
end
