class TestScene
  attr_reader :width, :height

  def initialize
    @width = 1000
    @height = 1000

    @controls = Controls.new($config.data['controls'])

    @square = Square.new(self, 500, 0)
  end

  def update
    @controls.update
    @square.update @controls
  end

  def draw
    @square.draw
    #Gosu::draw_rect(@square.x, $window.height - @square.y - @square.height, @square.width, @square.height, Gosu::Color::WHITE)
  end

  def button_down(id)
    if id == Gosu::KbEscape
      $window.close
    end
  end

  def button_up(id)
  end
end
