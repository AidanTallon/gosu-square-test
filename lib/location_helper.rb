class LocationHelper
  def initialize(scene_width, scene_height)
    @scene_width = scene_width
    @scene_height = scene_height
  end

  def screen_x_from_scene_x(x)
    ((x.to_f / @scene_width) * $window.width).to_i
  end

  def screen_width_from_scene_width(width)
    ((width.to_f / @scene_width) * $window.width).to_i
  end

  def screen_y_from_scene_y(y)
    $window.height - ((y.to_f / @scene_height) * $window.height).to_i
  end

  def screen_height_from_scene_height(height)
    ((height.to_f / @scene_height) * $window.height).to_i
  end

  def scene_x_from_screen_x(x)
    (x.to_f / $window.width) * @scene_width
  end

  def scene_y_fom_screen_y(y)
    $window.height - ((y.to_f / $window.height) * @scene_height)
  end
end
