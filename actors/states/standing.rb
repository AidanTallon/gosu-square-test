class Standing
  def initialize(actor)
    @actor = actor
  end

  def draw
    Gosu::draw_rect(@actor.x, $window.height - @actor.y - @actor.height, @actor.width, @actor.height, Gosu::Color::WHITE)
  end

  def action(controls)
    @actor.refresh_air_jumps
    b_down = controls.buttons_down
    if b_down.include? controls.up
      @actor.enter_state :jumpsquat
    end
    if b_down.include? controls.left
      @actor.move_left @actor.ground_speed
    end
    if b_down.include? controls.right
      @actor.move_right @actor.ground_speed
    end
    if b_down.include? controls.down
      @actor.enter_state :crouching
    end
  end
end
