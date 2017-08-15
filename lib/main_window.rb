class MainWindow < Gosu::Window

  def initialize
    super $config.window_height, $config.window_width, $config.fullscreen?

    self.caption = $gameData.title

    @current_scene = TestScene.new
  end

  def update
    @current_scene.update
  end

  def draw
    @current_scene.draw
  end

  def button_down(id)
    @current_scene.button_down(id)
  end

  def button_up(id)
    @current_scene.button_up(id)
  end
end
