class GamesController < ApplicationController
  before_filter :load_game, :except => [:index, :new, :create]
  
  def index
    @game = Game.new
  end

  def show
  end
  
  def new
    @game = Game.new
  end
  
  def create
    @game = Game.new(params[:game])
    if @game.save
      redirect_to @game
    else
      render :action => :index
    end
  end
  
  def update
    if @game.update_attributes(params[:game])
      render :nothing => true
    end
  end
  
  private
    def load_game
      @game = Game.find(params[:id])
    end

end
