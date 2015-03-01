class Api::CreatorController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
  before_action :api_auth
  before_action :api_key
  respond_to :json, :xml

  def index
    @creator = Creator.all
    respond_with @creator
  end
  def show
    creator = Creator.find(params[:id])
    respond_with creator.events
  end
  def new
    @creator = Creator.new
  end
  def create
    @creator =  Creator.new(creator_params)
    if @creator.save
      render json: { message: 'Succesfully added Creator' }, status: :created
    else
      render json: { error: 'Something went wrong. Make sure JSON is correct. e.g. {"creator":{"creator":"Mr Winston", "password": "Gentleman"}}' }, status: :bad_request
    end
  end
  #{"creator":{"creator":"Creator2"}}
  def update
    @creator = Creator.find(params[:id])
    if @creator.update_attributes(creator_params)
      render json: { message: 'Succesfully edited Creator' }, status: :accepted
    else
      render json: { error: 'Something went wrong. Make sure JSON is correct. e.g. {"creator":{"creator":"Mr Winston", "password": "Gentleman"}}' }, status: :bad_request
    end
  end
  private
  def creator_params
    params.require(:creator).permit(:creator,:password)
  end
end
