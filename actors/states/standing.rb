class Standing
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
    # refresh air jumps on every loop - would this have a performance cost?
    @actor.refresh_air_jumps

    # available inputs
    # - up to enter jumpsquat
    # - left/right to move
    # - down to enter crouch
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
