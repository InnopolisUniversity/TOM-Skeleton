class Api::V1::SettingsController < ApplicationController
  def index
    settings = TomSetting.all
    render json: settings, status: 200
  end

  def create

    request.body.rewind
    json = JSON.parse(
      case request.content_type
      when 'application/x-www-form-urlencoded'
        params[:payload]
      when 'application/json'
        request.body.read
      else
        raise "Invalid content-type: \"#{request.content_type}\""
      end
    )

    settings = TomSetting.new(
      agentname: json['agentname'],
      accesstokenendpoint: json['accesstokenendpoint'],
      authorizationbaseurl: json['authorizationbaseurl'],
      requesttokenendpoint: json['requesttokenendpoint'],
      authenticationmethod: json['authenticationmethod'],
      apikey: json['apikey'],
      apisecret: json['apisecret'],
      isactive: 'Y'
    )

    if settings.save
      render json: settings, status: 201
    else
      render json: {error: "Error creation entity"}, status: 400
    end
  end

  def show
    settings = TomSetting.find_by(id: params[:id])

    if project
      render json: settings, status: 200
    else
      render json: {error: "Project not found"}
    end
  end

  # private
  # def settings_params
  #   params.require(:settings).permit([
  #   :agentname,
  #   :accesstokenendpoint,
  #   :authorizationbaseurl,
  #   :requesttokenendpoint,
  #   :authenticationmethod,
  #   :apikey,
  #   :apisecret
  #                                    ])
  # end
end
