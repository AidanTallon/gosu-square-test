class TestScene
  include Location
  attr_reader :width, :height, :controls

  def initialize
    @width = 1000
    @height = 800

    @controls = Controls.new($config.data['controls'])

    @square = Square.new(self, 500, 0, @controls, $gameData.characters['jigglysquare'])
  end

  def update
    @square.update
  end

  def draw
    @square.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      $window.close
    end
    # should be moved when I move controls to specific actors
    @controls.input_queue.button_down(id)
  end

  def button_up(id)
  end
end
