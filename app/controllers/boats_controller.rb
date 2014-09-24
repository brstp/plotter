class BoatsController < ApplicationController
  before_action :set_boat, only: [:show, :edit, :update, :destroy]

  # GET /boats
  # GET /boats.json
  def index
    @boats = Boat.all
  end

  # GET /boats/1
  # GET /boats/1.json
  def show
      @polyjson = []
      roundpoints = []
                
      @waypoints = Array.new
      for round in @boat.rounds
        red = 0
        green = 0
        blue = 255
        color = red.to_s(16) + green.to_s(16) + blue.to_s(16)
        waypoint = Waypoint.find(round.waypoint_id)
        @waypoints << waypoint
        roundpoints << {:lng => waypoint.longitude, :lat => waypoint.latitude}
      end
      
      @polyline = roundpoints #.to_json
      
      red = 0     #00 --> ff
      green = 153 #99 --> 99
      blue = 255  #ff --> cc 255-->204
      steps = @waypoints.count  
      @hash = Gmaps4rails.build_markers(@waypoints) do |waypoint, marker|
        red_s = ("00" + red.to_s(16)).last 2
        green_s = ("00" + green.to_s(16)).last 2
        blue_s = ("00" + blue.to_s(16)).last 2
        colorcode=red_s + green_s + blue_s
        marker.lat waypoint.latitude
        marker.lng waypoint.longitude
        marker.json({:id => waypoint.name.to_i })
        marker.title waypoint.name
        marker.picture ({
         "url" => "https://chart.googleapis.com/chart?chst=d_map_spin&chld=0.6|000000|#{colorcode}|8|_|#{URI.encode(waypoint.name)}",
         "width" =>  23,
         "height" => 41,
         }) 
        red = (red + 255/steps).to_i 
        blue = (blue - 51/steps).to_i 
      end
  end

  # GET /boats/new
  def new
    @boat = Boat.new
  end

  # GET /boats/1/edit
  def edit
  end

  # POST /boats
  # POST /boats.json
  def create
    @boat = Boat.new(boat_params)

    respond_to do |format|
      if @boat.save
        format.html { redirect_to @boat, notice: 'Boat was successfully created.' }
        format.json { render :show, status: :created, location: @boat }
      else
        format.html { render :new }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boats/1
  # PATCH/PUT /boats/1.json
  def update
    respond_to do |format|
      if @boat.update(boat_params)
        format.html { redirect_to @boat, notice: 'Boat was successfully updated.' }
        format.json { render :show, status: :ok, location: @boat }
      else
        format.html { render :edit }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boats/1
  # DELETE /boats/1.json
  def destroy
    @boat.destroy
    respond_to do |format|
      format.html { redirect_to boats_url, notice: 'Boat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boat
      @boat = Boat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boat_params
      params.require(:boat).permit(:name, :period, :start_number)
    end
end
