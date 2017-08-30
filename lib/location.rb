module Location
  # from the x value related to a position in the SCENE, get x value relating to position on SCREEN
  def screen_x(x)
    ((x.to_f / @width) * $window.width).to_i
  end

  # from the width value related to the width of an object in the SCENE, get width related to SCREEN
  def screen_width(w)
    ((w.to_f / @width) * $window.width).to_i
  end

  # from the y value related to position in the SCENE, get y value relating to position on SCREEN
  def screen_y(y)
    $window.height - ((y.to_f / @height) * $window.height).to_i
  end

  # from the height value related to the height of an object in the SCENE, get height related to SCREEN
  def screen_height(h)
    ((h.to_f / @height) * $window.height).to_i
  end

  # from the x value related to position on SCREEN, get x value relating to position in the SCENE
  # is this needed?
  def scene_x(x)
    (x.to_f / $window.width) * @width
  end

  # from the y value related to position on SCREEN, get y value relating to position in the SCENE
  # is this needed?
  def scene_y(y)
    $window.height - ((y.to_f / $window.height) * @height)
  end
end
