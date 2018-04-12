class UsersController < ApplicationController

  API_KEY = "RGAPI-19a63e03-1fe1-44b9-be91-f5a552d4ae08"
  BASEURL = "https://na1.api.riotgames.com/lol/summoner/v3/summoners/by-name/"
  def index
    @users = User.all
    render json: @users
  end

  def create
    # @user = User.new(user_params)
    url = BASEURL + params[:summonerName] + "?api_key=" + API_KEY
    summonerInfo = JSON.parse(RestClient.get(url))
    @user= User.create(summonerName: params[:summonerName], accountId: summonerInfo["accountId"], profileIconId: summonerInfo["profileIconId"], summonerLevel: summonerInfo["summonerLevel"])

    render json: @user

  end

  def edit

  end

  def show

  end

  def update

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:summonerName)
  end
end
