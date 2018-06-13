class FightsController < ApplicationController
  before_action :set_fight, only: :show

  # GET /fights
  # GET /fights.json
  def index
    @fights = Fight.all
  end

  # GET /fights/1
  # GET /fights/1.json
  def show
    @winner = Fighter.find(@fight.winner_id)
    @looser = Fighter.find(@fight.looser_id)
  end

  # GET /fights/new
  def new
    @fighters = Fighter.all
    @fight = Fight.new
  end

  # POST /fights
  # POST /fights.json
  def create
    @fighters = Fighter.all
    @fight = Fight.create(Fight.fight_between(params[:one], params[:two]))

    respond_to do |format|
      if @fight.save
        format.html { redirect_to @fight, notice: 'Fight was successfully created.' }
        format.json { render :show, status: :created, location: @fight }
      else
        format.html { render :new }
        format.json { render json: @fight.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fight
      @fight = Fight.find(params[:id])
    end
end
