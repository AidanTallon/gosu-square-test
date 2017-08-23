class Crouching
  def initialize(actor)
    @actor = actor
  end

  def draw
    Gosu::draw_rect(@actor.x, $window.height - @actor.y - (@actor.height / 2), @actor.width, @actor.height / 2, Gosu::Color::WHITE)
  end

  def action(controls)
    @actor.refresh_air_jumps
    b_down = controls.buttons_down
    if !b_down.include? controls.down
      @actor.enter_state :standing
    end
    if b_down.include? controls.up
      @actor.enter_state :jumpsquat
    end
  end
end
