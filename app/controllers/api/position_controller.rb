class Api::PositionController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
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
      respond_with @position
    end
  end
  #{"position":{"position":"pos2"}}
  def update
    @position = Position.find(params[:id])
    if @position.update_attributes(position_params)
      respond_with @position
    end
  end
  private
  def position_params
    params.require(:position).permit(:lat,:long)
  end
end
