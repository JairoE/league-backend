class ChampionsController < ApplicationController


  URL = "https://na1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&dataById=false&api_key="
  API_KEY = "RGAPI-a921f358-b0db-4754-a474-2ce2c3ac2c62"
  IMAGEURL = "https://ddragon.leagueoflegends.com/cdn/8.7.1/img/champion/"
  def index
    @champs = Champion.all

    if(@champs.size == 0)
      url = URL + API_KEY
      champs = JSON.parse(RestClient.get(url))["data"]
      champs.each do |champ|
        champ = champ[1]
        name = champ["name"].gsub(/[ '.]/, "")
        image = IMAGEURL + name + ".png"
        Champion.create(champ_id: champ["id"], name: champ["name"], nickname: champ["title"], image_url: image)
      end
      @champs = Champion.all
    end

    render json: @champs
  end

  def show
    @champ = Champion.find_by(champ_id: params[:id])

    render json: @champ
  end

end
