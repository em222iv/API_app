class Api::EventController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token
  before_action :api_key
  before_action :api_auth, only: [:create,:update,:destroy]
  before_action :offset_params, only: [:index, :nearby]
  before_action :api_jwt_auth, only:[:update,:destroy]
  respond_to :json, :xml
  include SessionsHelper

  #http://localhost:3000/api/event.json?limit=10&offset=0
  def index

    if params[:query].present?
      query = '%'+params[:query]+'%'
      respond_with Event.all.where('description LIKE ?',query)
      return
    end

    @event = Event.all.order(created_at: :desc)
   if offset_params.present?
     @event = Event.limit(@limit).offset(@offset).order(created_at: :desc)
   end
    respond_with @event
  end
  def show
    respond_with Event.find(params[:id])
  end
  def new
    @event = Event.new
  end


  #create with tag
  #{ "event": { "positionID": "8", "creatorID": "8", "description":"skapaa"}, "tag": { "tag": "coole"}}
  def create
    @event =  Event.new(event_params)
    @tag = Tag.new(tag_params)
    @position = Position.new(position_params)

    if Tag.find_by_tag(@tag.tag).present?
      @tag = Tag.find_by_tag(@tag.tag)
    end
    @event.tags << @tag
    @event.position = @position
    @event.creator_id = @creator_id
    if @event.save && @tag.save && @position.save
      render json: { message: 'Succesfully added' }, status: :accepted
      else
    render json: { error: 'Something went wrong. Make sure JSON is correct. e.g.{"event":{"position_id":2,"creator_id":2, "description": "beskrivande text"}} or {"event":{"position_id":2,"creator_id":2, "description": "beskrivande text"}, "tag": { "tag": "youre tag"}}' }, status: :bad_request
    end
  end
  #
  #{"id":3,"tagID":3,"positionID":3,"created_at":"2015-02-18T12:48:19.772Z","updated_at":"2015-02-18T12:57:20.138Z"}
  def update
    @event = Event.find(params[:id])
    @position = Position.find(params[:id])

    if @event.creator_id == @token_payload[0]['creator_id']
      if @event.update_attributes(event_params) && @position.update_attributes(position_params)
        render json: { message: 'Succesfully edited event'}, status: :accepted
      else
        render json: { error: 'Something went wrong. Make sure JSON is correct. e.g.{"event":{"position_id":2,"creator_id":2, "description": "beskrivande text"}} or {"event":{"position_id":2,"creator_id":2, "description": "beskrivande text"}, "tag": { "tag": "youre tag"}}' }, status: :bad_request
      end
    end
  end
  def destroy
    @event = Event.find(params[:id])
    @event.delete
    render json: { message: 'Succesfully deleted event'}, status: :accepted
  end
  # This method is using the geocoder and helps with searching near a specific position
  def nearby
    # Check the parameters
    if params[:lat].present? && params[:long].present?
      # using the parameters and offset/limit
      position = Position.near([params[:lat].to_f, params[:long].to_f], 1000).limit(@limit).offset(@offset)
      if position position.map(&:events) == []
        render json: { message: 'No nearby events'}, status: :accepted
      end
      respond_with position.map(&:events), status: :ok
    else
     # error = ErrorMessage.new("Could not find any resources. Bad parameters?", "Could not find any team!" )
      render json: { message: 'There is something wrong with your request.'}, status: :bad_request
    end
  end
  private
  def event_params
    params.require(:event).permit(:position_id,:creator_id,:description)
  end
  def tag_params
    params.require(:tag).permit(:tag)
  end
  def position_params
    params.require(:position).permit(:lat,:long)
  end
end