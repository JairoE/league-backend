class MatchesController < ApplicationController

  API_KEY = "RGAPI-a1a853f0-9ed7-458a-8b2c-22426860fe0b"
  BASEURL = "https://na1.api.riotgames.com/lol/match/v3/matchlists/by-account/"
  MATCHBASEURL = "https://na1.api.riotgames.com/lol/match/v3/matches/"

  def index
    @user = User.find(params[:user_id])
    accountId = @user.accountId
    url = BASEURL + accountId.to_s + '/recent?api_key=' + API_KEY
    json = JSON.parse(RestClient.get(url))
    matchList = json["matches"]

    @matches = createMatches(matchList, @user)

    render json: @matches
  end

  def createMatches(matchList, user)
    matchList.map do |match|
      match = Match.find_or_create_by(game_id: match['gameId'].to_s)
      UserMatch.find_or_create_by(match_id: match.id, user_id: user.id)
      match
    end
  end

  def show
    game= Match.find(params[:id])

    if(game[:game_info] == nil)
      url = MATCHBASEURL + game['game_id'] + '?api_key=' + API_KEY
      gameInfo = JSON.parse(RestClient.get(url))
      stringRep = gameInfo.to_s
      game.update(game_info: stringRep)
    end

    stringRep = game[:game_info]

    render json: eval(stringRep)

  end

end
