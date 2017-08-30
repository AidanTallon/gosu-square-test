class Square
  attr_reader :width, :height,
              :jumpsquat_length,
              :ground_speed,
              :air_speed,
              :max_air_jumps,
              :initial_vertical_velocity,
              :initial_shorthop_vertical_velocity,
              :min_vertical_velocity,
              :scene

  attr_accessor :active_jumpsquat,
                :full_hop,
                :air_jumps,
                :x, :y,
                :current_vertical_velocity

  def initialize(scene, x_pos, y_pos, width = 50, height = 50)
    @scene = scene
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height

    @jumpsquat_length = 10

    @ground_speed = 2
    @air_speed = 1
    @max_air_jumps = 1

    # velocity at start of jump
    @initial_vertical_velocity = 20
    # velocity at start of jump while short hopping
    @initial_shorthop_vertical_velocity = 12
    # lower values mean a faster MAX fall speed
    @min_vertical_velocity = -20
    # just means you're not moving up or down - probably shouldn't need to be set to 0 in init
    @current_vertical_velocity = 0

    # states available to actor
    @standing_state = Standing.new self
    @crouching_state = Crouching.new self
    @jumpsquat_state = Jumpsquat.new self
    @jumping_state = Jumping.new self

    # initial state should be calculated, not hard coded - what if you spawn in air?
    @state = @standing_state
  end

  # changes @state to corresponding state, as well as holding rules for entering state
  # e.g. when entering jumpsquat, set @active_jumpsquat to @jumpsquat_length to begin counting down jumpsquat frames
  def enter_state(state)
    if state == :jumpsquat
      @full_hop = true
      @active_jumpsquat = @jumpsquat_length
      @state = @jumpsquat_state
    elsif state == :jumping
      @current_vertical_velocity = @full_hop ? @initial_vertical_velocity : @initial_shorthop_vertical_velocity
      @state = @jumping_state
    elsif state == :crouching
      @state = @crouching_state
    elsif state == :standing
      @state = @standing_state
    end
  end

  # called in the update loop for corresponding states, as opposed to when entering the state
  # just in case? maybe that should be changed
  def refresh_air_jumps
    @air_jumps = @max_air_jumps
  end

  # draw the actor as specified by it's current state
  def draw
    @state.draw
  end

  # maybe should be move_x ?
  def move_left(dist)
    @x -= dist
  end

  # maybe should be move_x ?
  def move_right(dist)
    @x += dist
  end

  # call the states update method, where possible actions are specified
  def update(controls)
    @state.action controls
  end
end
