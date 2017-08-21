class Jumpsquat
  def initialize(actor)
    @actor = actor
  end

  def draw
    Gosu::draw_rect(@actor.x, $window.height - @actor.y - (@actor.height / 2), @actor.width, @actor.height / 2, Gosu::Color::WHITE)
  end

  def action(controls)
    if !controls.buttons_down.include? controls.up
      @actor.full_hop = false
    end
    @actor.active_jumpsquat -= 1
    if @actor.active_jumpsquat <= 0
      @actor.enter_state :jumping
    end
  end
end
