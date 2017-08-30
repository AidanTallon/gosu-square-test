class Crouching
  # actor corresponds to the actor who possesses this state
  def initialize(actor)
    @actor = actor
  end

  def draw
    Gosu::draw_rect(@actor.x, $window.height - @actor.y - (@actor.height / 2), @actor.width, @actor.height / 2, Gosu::Color::WHITE)
  end

  def action(controls)
    # refresh air jumps on every loop - would this have a preformance cost?
    @actor.refresh_air_jumps

    #available inputs
    # - up to enter jumpsquat
    # - down must be held to remain crouching
    b_down = controls.buttons_down
    if !b_down.include? controls.down
      @actor.enter_state :standing
    end
    if b_down.include? controls.up
      @actor.enter_state :jumpsquat
    end
  end
end
