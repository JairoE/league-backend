class MatchesController < ApplicationController

  API_KEY = "RGAPI-7a68b006-ea8d-4c23-86db-d78400453fcd"
  BASEURL = "https://na1.api.riotgames.com/lol/match/v3/matchlists/by-account/"
  MATCHBASEURL = "https://na1.api.riotgames.com/lol/match/v3/matches/"

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
                end.sort_by do |match|
                  (match.game_id)
                end.reverse[0..16]

    render json: @matches
  end

  def createMatches(matchList, user)
    matchList.map do |match|
      matchId = Match.find_or_create_by(game_id: match['gameId'].to_s)
      UserMatch.find_or_create_by(match_id: matchId.id, user_id: user.id)
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
