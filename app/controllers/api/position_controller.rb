class Api::PositionController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
  before_action :api_key
  before_action :api_auth, only: [:index,:show]

  respond_to :json, :xml

  def index
    @position = Position.all
    respond_with @position
  end
  def show
    respond_with Position.find(params[:id])
  end
  def new
    @position = Position.new
  end
  #{"position":{"position":"possiiii"}}
  def create
    @position =  Position.new(position_params)
    if @position.save
      render json: { message: 'Succesfully added position' }, status: :created
    else
      render json: { error: 'Something went wrong. Make sure JSON is correct. e.g. {"position":{"lat":40.34, "long": 50.12}}' }, status: :bad_request

    end
  end
  #{"position":{"position":"pos2"}}
  def update
    @position = Position.find(params[:id])
    if @position.update_attributes(position_params)
      render json: { message: 'Succesfully edited position' }, status: :accepted
    end
  else
    render json: { error: 'Something went wrong. Make sure JSON is correct. e.g. {"position":{"lat":44.34, "long": 51.12}}' }, status: :bad_request
  end
  private
  def position_params
    params.require(:position).permit(:lat,:long)
  end
end
