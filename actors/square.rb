class Square
  attr_reader :width, :height,
              :jumpsquat_length,
              :ground_speed,
              :air_speed,
              :max_air_jumps,
              :initial_vertical_velocity,
              :initial_shorthop_vertical_velocity,
              :min_vertical_velocity

  attr_accessor :active_jumpsquat,
                :full_hop,
                :air_jumps,
                :x, :y,
                :current_vertical_velocity

  def initialize(x_pos, y_pos, width = 50, height = 50)
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height
    @jumpsquat_length = 10
    @state = :standing
    @ground_speed = 2
    @air_speed = 1
    @max_air_jumps = 2

    @initial_vertical_velocity = 20
    @initial_shorthop_vertical_velocity = 12
    @min_vertical_velocity = -20
    @current_vertical_velocity = 0


    # states
    @standing_state = Standing.new self
    @crouching_state = Crouching.new self
    @jumpsquat_state = Jumpsquat.new self
    @jumping_state = Jumping.new self

    @state = @standing_state
  end

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

  def refresh_air_jumps
    @air_jumps = @max_air_jumps
  end

  def draw
    @state.draw
  end

  def move_left(dist)
    @x -= dist
  end

  def move_right(dist)
    @x += dist
  end

  def update(controls)
    @state.action controls
  end
end
