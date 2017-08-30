class Jumpsquat
  # actor corresponds to the actor who possesses this state
  def initialize(actor)
    @actor = actor
  end

  def draw
    Gosu::draw_rect(@actor.x, $window.height - @actor.y - (@actor.height / 2), @actor.width, @actor.height / 2, Gosu::Color::WHITE)
  end

  def action(controls)
    # check every loop that the up key is held. if at any point it is NOT, we will short hop instead of full hop
    # this should probably use the input queue, and check as we enter JUMP, instead of every loop of jumpsquat
    if !controls.buttons_down.include? controls.up
      @actor.full_hop = false
    end
    # count down the active jumpsquat frames
    @actor.active_jumpsquat -= 1
    if @actor.active_jumpsquat <= 0
      @actor.enter_state :jumping
    end

    # available inputs - none
  end
end
