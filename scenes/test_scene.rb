class TestScene
  include Location
  attr_reader :width, :height

  def initialize
    @width = 1000
    @height = 800

    @controls = Controls.new($config.data['controls'])

    @square = Square.new(self, 500, 0, $gameData.characters['jigglysquare'])
  end

  def update
    @controls.update
    @square.update @controls
  end

  def draw
    @square.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      $window.close
    end
  end

  def button_up(id)
  end
end
