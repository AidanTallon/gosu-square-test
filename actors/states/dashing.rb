class Dashing
  # actor corresponds to the actor who possesses this state
  def initialize(actor)
    @actor = actor
  end

  def draw
    Gosu::draw_rect(@actor.scene.screen_x(@actor.x),
                    @actor.scene.screen_y(@actor.y + (@actor.height / 2)),
                    @actor.scene.screen_width(@actor.width),
                    @actor.scene.screen_height(@actor.height / 2),
                    Gosu::Color::WHITE)
  end

  def action(controls)
    # available inputs
    # - down to crouch

    b_down = controls.buttons_down
    if b_down.include? controls.down
      @actor.enter_state :crouching
    end

    if @actor.facing == :left
      @actor.move_left(@actor.dash_speed)
    elsif @actor.facing == :right
      @actor.move_right(@actor.dash_speed)
    else
      raise 'you fucked up'
    end

    @actor.active_dash -= 1
    if @actor.active_dash < 0
      @actor.enter_state :standing
    end
  end
end
