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
    # TODO - dash
    case controls.input_queue.check_queue
    when :dash_left
      @actor.enter_state :dashing
    when :dash_right
      @actor.enter_state :dashing
    end
    b = controls.buttons_down
    if b.include? controls.up
      @actor.enter_state :jumpsquat
    elsif b.include? controls.down
      @actor.enter_state :crouching
    elsif b.include? controls.left
      @actor.facing = :left
      @actor.move_left @actor.ground_speed
    elsif b.include? controls.right
      @actor.facing = :right
      @actor.move_right @actor.ground_speed
    end
  end
end
