class MatchesController < ApplicationController

  API_KEY = "RGAPI-4dbfac0f-9a91-4ba4-bfa5-923529e00677"
  BASEURL = "https://na1.api.riotgames.com/lol/match/v3/matchlists/by-account/"

  def index
    @user = User.find(params[:user_id])
    accountId = @user.accountId
    url = BASEURL + accountId.to_s + '?api_key=' + API_KEY
    matchList = JSON.parse(RestClient.get(url))["matches"]

    byebug
    createMatches(matchList)
    byebug

  end

  def createMatches(matchList)
    matchList.map do |match|
      Match.find_or_create_by(game_id: match['gameId'].to_s)
    end
  end

  def create
  end

end
