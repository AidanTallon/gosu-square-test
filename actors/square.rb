class Square
  attr_reader :width, :height,
              :jumpsquat_length,
              :ground_speed,
              :air_speed,
              :max_air_jumps,
              :initial_vertical_velocity,
              :initial_shorthop_vertical_velocity,
              :min_vertical_velocity,
              :scene,
              :controls,
              :dash_speed,
              :air_dash_speed

  attr_accessor :active_jumpsquat,
                :full_hop,
                :air_jumps,
                :x, :y,
                :current_vertical_velocity,
                :active_dash,
                :active_air_dash

  def initialize(scene, x_pos, y_pos, controls, params)
    @scene = scene

    @controls = controls

    @x = x_pos
    @y = y_pos
    @width = params['width']
    @height = params['height']

    @jumpsquat_length = params['jumpsquat_length']

    @ground_speed = params['ground_speed']
    @air_speed = params['air_speed']
    @max_air_jumps = params['max_air_jumps']

    @dash_speed = params['dash_speed']
    @dash_duration = params['dash_duration']

    @air_dash_speed = params['air_dash_speed']
    @air_dash_distance = params['air_dash_distance']
    @air_dash_duration = @air_dash_distance / @air_dash_speed

    # hard coded?
    @facing = :right

    # velocity at start of jump
    @initial_vertical_velocity = params['initial_vertical_velocity']
    # velocity at start of jump while short hopping
    @initial_shorthop_vertical_velocity = params['initial_shorthop_vertical_velocity']
    # lower values mean a faster MAX fall speed
    @min_vertical_velocity = params['min_vertical_velocity']
    # just means you're not moving up or down - probably shouldn't need to be set to 0 in init
    @current_vertical_velocity = 0

    # states available to actor
    @standing_state = Standing.new self
    @crouching_state = Crouching.new self
    @jumpsquat_state = Jumpsquat.new self
    @jumping_state = Jumping.new self
    @dashing_state = Dashing.new self
    @air_dashing_state = AirDashing.new self

    # initial state should be calculated, not hard coded - what if you spawn in air?
    @state = @standing_state
  end

  # changes @state to corresponding state, as well as holding rules for entering state
  # e.g. when entering jumpsquat, set @active_jumpsquat to @jumpsquat_length to begin counting down jumpsquat frames
  def enter_state(state, opts = {})
    if state == :jumpsquat
      @full_hop = true
      @active_jumpsquat = @jumpsquat_length
      @state = @jumpsquat_state
    elsif state == :jumping
      @state = @jumping_state
    elsif state == :crouching
      @state = @crouching_state
    elsif state == :standing
      @state = @standing_state
    elsif state == :dashing
      @active_dash = @dash_duration
      @state = @dashing_state
    elsif state == :air_dashing
      @active_air_dash = @air_dash_duration
      @air_dashing_state.direction = opts[:direction]
      @state = @air_dashing_state
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

  def facing
    @facing
  end

  def facing=(dir)
    @facing = dir
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
  def update
    # TODO - params for dashing (facing)
    @controls.update # why is this here?
    @state.action @controls
  end
end
