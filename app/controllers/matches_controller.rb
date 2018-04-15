class MatchesController < ApplicationController

  API_KEY = "RGAPI-97b7709f-c97c-4bf7-8f73-252211443cbf"
  BASEURL = "https://na1.api.riotgames.com/lol/match/v3/matchlists/by-account/"

  def index
    @user = User.find(params[:user_id])
    accountId = @user.accountId
    url = BASEURL + accountId.to_s + '?api_key=' + API_KEY
    json = JSON.parse(RestClient.get(url))
    matchList = json["matches"]
    numOfGames = json["total"]

    createMatches(matchList, @user)
    @usermatches = UserMatch.where(user_id: @user.id)
    @matches = @usermatches.map do |usermatch|
                  Match.find(usermatch.match_id)
                end


    render json: @matches
  end

  def createMatches(matchList, user)
    matchList.map do |match|
      matchId = Match.find_or_create_by(game_id: match['gameId'].to_s)
      UserMatch.find_or_create_by(match_id: matchId.id, user_id: user.id)
    end
  end

  def create
  end

end
