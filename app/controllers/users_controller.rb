class UsersController < ApplicationController

  API_KEY = "RGAPI-a1a853f0-9ed7-458a-8b2c-22426860fe0b"
  BASEURL = "https://na1.api.riotgames.com/lol/summoner/v3/summoners/by-name/"
  RANKURL = "https://na1.api.riotgames.com/lol/league/v3/positions/by-summoner/"

  def index
    @users = User.all
    render json: @users
  end

  def sign_up

    url = BASEURL + params[:summonerName] + "?api_key=" + API_KEY
    summonerInfo = JSON.parse(RestClient.get(url))
    @user= User.find_or_create_by(summonerName: summonerInfo["name"], accountId: summonerInfo["accountId"], profileIconId: summonerInfo["profileIconId"], summonerLevel: summonerInfo["summonerLevel"], email: user_params["email"], summonerId: summonerInfo["id"])

    render json: @user

  end

  def sign_in

    url = BASEURL + params[:summonerName] + "?api_key=" + API_KEY
    summonerInfo = JSON.parse(RestClient.get(url))
    @user= User.find_by(summonerName: summonerInfo["name"], email: params[:email])

    render json: @user

  end

  def fetch_user

    url = BASEURL + params[:summonerName] + "?api_key=" + API_KEY
    summonerInfo = JSON.parse(RestClient.get(url))
    @user= User.find_or_create_by(summonerName: summonerInfo["name"], accountId: summonerInfo["accountId"], profileIconId: summonerInfo["profileIconId"], summonerLevel: summonerInfo["summonerLevel"], summonerId: summonerInfo["id"])

    render json: @user

  end

  def fetch_rank
    user = User.find(params[:id])
    url = RANKURL + user["summonerId"].to_s + "?api_key=" + API_KEY
    summonerInfo = JSON.parse(RestClient.get(url))

    render json: summonerInfo


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
    params.require(:user).permit(:summonerName, :email)
  end
end
