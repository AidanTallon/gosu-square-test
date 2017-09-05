class AirDashing
  attr_accessor :direction

# actor corresponds to the actor who possesses this state
  def initialize(actor)
    @actor = actor
  end

  def draw
    Gosu::draw_rect(@actor.scene.screen_x(@actor.x),
                    @actor.scene.screen_y(@actor.y + (@actor.height / 2)),
                    @actor.scene.screen_width(@actor.width),
                    @actor.scene.screen_height(@actor.height / 1.75),
                    Gosu::Color::WHITE)
  end

  def action(controls)
    # available inputs
    # - down to exit dash

    b_down = controls.buttons_down
    if b_down.include? controls.down
      @actor.enter_state :jumping
    end

    if @direction == :left
      @actor.move_left @actor.air_dash_speed
    elsif @direction == :right
      @actor.move_right @actor.air_dash_speed
    else
      raise 'you fucked up'
    end

    @actor.active_air_dash -= 1
    if @actor.active_air_dash < 0
      @actor.enter_state :jumping
    end
  end
end
