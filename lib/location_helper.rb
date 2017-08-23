class LocationHelper
  def initialize(scene_width, scene_height)
    @scene_width = scene_width
    @scene_height = scene_height
  end

  # from the x value related to position in the SCENE, get x value relating to position on SCREEN
  def screen_x(x)
    ((x.to_f / @scene_width) * $window.width).to_i
  end

  # from the width value related to the width of an object in the SCENE, get width related to SCREEN
  def screen_width(width)
    ((width.to_f / @scene_width) * $window.width).to_i
  end

  # from the y value related to position in the SCENE, get y value relating to position on SCREEN
  def screen_y(y)
    $window.height - ((y.to_f / @scene_height) * $window.height).to_i
  end

  # from the height value related to the height of an object in the SCENE, get height related to SCREEN
  def screen_height(height)
    ((height.to_f / @scene_height) * $window.height).to_i
  end

  # from the x value related to position on SCREEN, get x value relating to position in the SCENE
  def scene_x(x)
    (x.to_f / $window.width) * @scene_width
  end

  # from the y value related to position on SCREEN, get y value relating to position in the SCENE
  def scene_y(y)
    $window.height - ((y.to_f / $window.height) * @scene_height)
  end
end
