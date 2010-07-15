class Tile < ActiveRecord::Base
  belongs_to :game
  
  def check
    mine = self.game.mines.find_by_x_and_y(x,y)
    if mine
      mines = self.game.mines.all(:select => 'x,y')
      mine_grid = Array.new
      mines.each do |m|
        mine_grid << {:x=>m.x,:y=>m.y}
      end
      return {:status=>0,:mines => mine_grid}
    end  
    tile = self.game.tiles.find_by_x_and_y(x,y)
    if tile.cleared
      return { :status =>1}
    else
      results = tile.search
      return {:status =>2, :tiles => results}
    end
  end
  
  def search
    if(y > 0 && y <= 8 && x > 0 && x <= 8 && cleared != true && flagged != true)
      count = self.check_around
      self.cleared = true
      self.save
      logger.warn("Checking Tile x:#{x}, y:#{y} with count: #{count}")
      others = Array.new
      if count == 0 
        tile = self.game.tiles.find_by_x_and_y(x-1,y-1)
        others << tile.search if tile
        tile = self.game.tiles.find_by_x_and_y(x-1,y)
        others << tile.search if tile
        tile = self.game.tiles.find_by_x_and_y(x-1,+1)
        others << tile.search if tile
        tile = self.game.tiles.find_by_x_and_y(x,y-1)
        others << tile.search if tile
        tile = self.game.tiles.find_by_x_and_y(x,y+1)
        others << tile.search if tile
        tile = self.game.tiles.find_by_x_and_y(x+1,y-1)
        others << tile.search if tile
        tile = self.game.tiles.find_by_x_and_y(x+1,y)
        others << tile.search if tile
        tile = self.game.tiles.find_by_x_and_y(x+1,y+1)
        others << tile.search if tile
      end
      return others.flatten.compact << {:count => count, :x => x, :y => y}
    end
    return []
  end
  
  def check_around
    count = 0
    logger.warn('checking surrounding mines')
    if y > 1 && x > 1
      mine = self.game.mines.find_by_x_and_y(x-1,y-1)
      count = count+1 if mine
    end
    if y > 1
      mine = self.game.mines.find_by_x_and_y(x,y-1)
      count = count+1 if mine
    end
    if y > 1 && x < 8
      mine = self.game.mines.find_by_x_and_y(x+1,y-1)
      count = count+1 if mine
    end
    if x > 1
      mine = self.game.mines.find_by_x_and_y(x-1,y)
      count = count+1 if mine
    end
    if x < 8
      mine = self.game.mines.find_by_x_and_y(x+1,y)
      count = count+1 if mine
    end
    if y < 8 && x > 1
      mine = self.game.mines.find_by_x_and_y(x-1,y+1)
      count = count+1 if mine
    end
    if y < 8
      mine = self.game.mines.find_by_x_and_y(x,y+1)
      count = count+1 if mine
    end
    if y < 8 && x < 8
      mine = self.game.mines.find_by_x_and_y(x+1,y+1)
      count = count+1 if mine
    end
    return count
  end
end
