class TestScene
  def initialize
    @controls = Controls.new($config.data['controls'])

    @square = Square.new(@controls, 500, 0)
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
  end

  def button_up(id)
  end
end
