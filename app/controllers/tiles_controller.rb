class TilesController < ApplicationController
  before_filter :load_game
  
  def index
    @tile = @game.tiles.find_by_x_and_y(params[:tile][:x], params[:tile][:y])
    
    if params[:flag]
      @tile.update_attributes({:flagged => !@tile.flagged})
    else
      render :json => @tile.check
    end
  end
  
  private
  def load_game
    @game = Game.find(params[:game_id])
  end

end
