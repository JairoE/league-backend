class UsersController < ApplicationController

  API_KEY = "RGAPI-4dbfac0f-9a91-4ba4-bfa5-923529e00677"
  BASEURL = "https://na1.api.riotgames.com/lol/summoner/v3/summoners/by-name/"
  def index
    @users = User.all
    render json: @users
  end

  def create

    url = BASEURL + params[:summonerName] + "?api_key=" + API_KEY
    summonerInfo = JSON.parse(RestClient.get(url))
    @user= User.find_or_create_by(summonerName: summonerInfo["name"], accountId: summonerInfo["accountId"], profileIconId: summonerInfo["profileIconId"], summonerLevel: summonerInfo["summonerLevel"])

    render json: @user

  end

  def edit

  end

  def show
    @user = User.find(params[:id])

    render json: @user
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
