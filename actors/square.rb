class Square
  attr_reader :x, :y, :width, :height

  def initialize(controls, x_pos, y_pos, width = 50, height = 50)
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height
    @jumpsquat_length = 4
    @state = :standing
    @ground_speed = 4
    @air_speed = 1
    @max_air_jumps = 2
    @facing = :left

    @initial_vertical_velocity = 20
    @initial_shorthop_vertical_velocity = 12
    @min_vertical_velocity = -20
    @current_vertical_velocity = 0
    @dash_length = 15
    @dash_speed = 10
    @dash_remaining = 0

    @controls = controls
  end

  def draw
    if @state == :jumpsquat
      jumpsquat_draw
    elsif @state == :crouching
      crouching_draw
    elsif @state == :standing
      standing_draw
    elsif @state == :jumping
      jumping_draw
    elsif @state == :dashing
      dashing_draw
    end
  end

  def crouching_draw
    Gosu::draw_rect(@x, $window.height - @y - (@height / 2), @width, @height / 2, Gosu::Color::WHITE)
  end

  def standing_draw
    Gosu::draw_rect(@x, $window.height - @y - @height, @width, @height, Gosu::Color::WHITE)
  end

  def jumping_draw
    Gosu::draw_rect(@x, $window.height - @y - @height, @width, @height, Gosu::Color::WHITE)
  end

  def jumpsquat_draw
    Gosu::draw_rect(@x, $window.height - @y - (@height / 2), @width, @height / 2, Gosu::Color::WHITE)
  end

  def dashing_draw
    standing_draw
  end

  def move_left(dist)
    @x -= dist
  end

  def move_right(dist)
    @x += dist
  end

  def start_jumpsquat
    @state = :jumpsquat
    @fullhop = true
    @active_jumpsquat = @jumpsquat_length
  end

  def start_jump
    @current_vertical_velocity = @fullhop ? @initial_vertical_velocity : @initial_shorthop_vertical_velocity
    @state = :jumping
  end

  def air_jump
    @current_vertical_velocity = @initial_vertical_velocity
    @air_jumps -= 1
  end

  def jumpsquat_action
    if !@controls.buttons_down.include? @controls.up
      @fullhop = false
    end
    @active_jumpsquat -= 1
    if @active_jumpsquat <= 0
      start_jump
    end
  end

  def jumping_action
    b_down = @controls.buttons_down
    if @air_jumps > 0 and @controls.buttons_pressed_this_frame.include? @controls.up
      air_jump
    end
    if @current_vertical_velocity <= 0 and b_down.include? @controls.down
      @current_vertical_velocity = @min_vertical_velocity
    end
    if b_down.include? @controls.left
      move_left(@air_speed)
    end
    if b_down.include? @controls.right
      move_right(@air_speed)
    end
    @y += (@current_vertical_velocity / 2)
    @current_vertical_velocity = [@current_vertical_velocity - 1, @min_vertical_velocity].max
    if @y <= 0
      @y = 0
      @state = :standing
    end
  end

  def standing_action
    @air_jumps = @max_air_jumps
    b_down = @controls.buttons_down
    if @controls.input_queue.check_for :dash
      start_dash
    end
    if b_down.include? @controls.up
      start_jumpsquat
    end
    if b_down.include? @controls.left
      move_left(@ground_speed)
    end
    if b_down.include? @controls.right
      move_right(@ground_speed)
    end
    if b_down.include? @controls.down
      @state = :crouching
    end
  end

  def crouching_action
    @air_jumps = @max_air_jumps
    b_down = @controls.buttons_down
    if !b_down.include? @controls.down
      @state = :standing
    end
    if b_down.include? @controls.up
      start_jumpsquat
    end
  end

  def dashing_action
    if @controls.buttons_down.include? @controls.down
      @state = :crouching
    end
    if @dash_remaining > 0
      if @facing == :left
        @x -= @dash_speed
      elsif @facing == :right
        @x += @dash_speed
      end
      @dash_remaining -= 1
    else
      @state = :standing
    end
  end

  def start_dash
    b_down = @controls.buttons_down
    @dash_remaining = @dash_length
    if b_down.include? @controls.left
      @facing = :left
    elsif b_down.include? @controls.right
      @facing = :right
    end
    @state = :dashing
  end

  def update
    @controls.update
    if @state == :jumpsquat
      jumpsquat_action
    elsif @state == :jumping
      jumping_action
    elsif @state == :standing
      standing_action
    elsif @state == :crouching
      crouching_action
    elsif @state == :dashing
      dashing_action
    end
  end
end
