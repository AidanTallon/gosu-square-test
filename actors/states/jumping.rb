class Jumping
  def initialize(actor)
    @actor = actor
  end

  def draw
    Gosu::draw_rect(@actor.x, $window.height - @actor.y - @actor.height, @actor.width, @actor.height, Gosu::Color::WHITE)
  end

  def action(controls)
    b_down = controls.buttons_down
    if @actor.air_jumps > 0 and controls.buttons_pressed_this_frame.include? controls.up
      air_jump
    end
    if @actor.current_vertical_velocity <= 0 and b_down.include? controls.down
      @actor.current_vertical_velocity = @actor.min_vertical_velocity
    end
    if b_down.include? controls.left
      @actor.move_left @actor.air_speed
    end
    if b_down.include? controls.right
      @actor.move_right @actor.air_speed
    end
    @actor.y += (@actor.current_vertical_velocity / 2)
    @actor.current_vertical_velocity = [@actor.current_vertical_velocity - 1, @actor.min_vertical_velocity].max
    if @actor.y <= 0
      @actor.y = 0
      @actor.enter_state :standing
    end
  end

  def air_jump
    @actor.current_vertical_velocity = @actor.initial_vertical_velocity
    @actor.air_jumps -= 1
  end
end
