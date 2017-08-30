class Jumping
  # actor corresponds to the actor who possesses this state
  def initialize(actor)
    @actor = actor
  end

  def draw
    Gosu::draw_rect(@actor.scene.screen_x(@actor.x),
                    @actor.scene.screen_y(@actor.y + @actor.height),
                    @actor.scene.screen_width(@actor.width),
                    @actor.scene.screen_height(@actor.height),
                    Gosu::Color::WHITE)
  end

  def action(controls)
    # available inputs
    # - up to air jump
    # - down to fast fall
    # - left/right to move
    b_down = controls.buttons_down
    # only jump when air_jumps > 0
    if @actor.air_jumps > 0 and controls.buttons_pressed_this_frame.include? controls.up
      air_jump
    end
    # only fast fall if velocity is NEGATIVE (on downward trajectory)
    if @actor.current_vertical_velocity <= 0 and b_down.include? controls.down
      @actor.current_vertical_velocity = @actor.min_vertical_velocity
    end
    if b_down.include? controls.left
      @actor.move_left @actor.air_speed
    end
    if b_down.include? controls.right
      @actor.move_right @actor.air_speed
    end
    # move y by velocity / 2 -- not sure why this calculation, so let's take a look at some point
    @actor.y += (@actor.current_vertical_velocity / 2)
    # velocity decreases by 1 each loop until the min_vertical_velocity is reached
    @actor.current_vertical_velocity = [@actor.current_vertical_velocity - 1, @actor.min_vertical_velocity].max
    # enter standing if y == 0 -- will need to be changed when platforms are introduced
    if @actor.y <= 0
      @actor.y = 0
      @actor.enter_state :standing
    end
  end

  # when air_jumping we reset the vertical velocity - maybe this should be changed so air jumps do not have an identical trajectory to ground jumps
  def air_jump
    @actor.current_vertical_velocity = @actor.initial_vertical_velocity
    @actor.air_jumps -= 1
  end
end
