class Square
  attr_reader :x, :y, :width, :height

  def initialize(x_pos, y_pos, width = 50, height = 50)
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height
    @jump_height = 100
    @jumpsquat_length = 10
    @state = :standing
    @ground_speed = 2
    @air_speed = 1

    @initial_vertical_velocity = 20
    @min_vertical_velocity = -20
    @current_vertical_velocity = 0
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

  def move_left(dist)
    @x -= dist
  end

  def move_right(dist)
    @x += dist
  end

  def start_jumpsquat
      @state = :jumpsquat
      @active_jumpsquat = @jumpsquat_length
  end

  def start_jump
    @current_vertical_velocity = @initial_vertical_velocity
    @state = :jumping
  end

  def jumpsquat_action(controls)
    @active_jumpsquat -= 1
    if @active_jumpsquat <= 0
      start_jump
    end
  end

  def jumping_action(controls)
    b_down = controls.buttons_down
    if b_down.include? controls.left
      move_left(@air_speed)
    end
    if b_down.include? controls.right
      move_right(@air_speed)
    end
    @y += (@current_vertical_velocity / 2)
    @current_vertical_velocity = [@current_vertical_velocity - 1, @min_vertical_velocity].max
    if @y <= 0
      @y = 0
      @state = :standing
    end
  end

  def standing_action(controls)
    b_down = controls.buttons_down
    if b_down.include? controls.up
      start_jumpsquat
    end
    if b_down.include? controls.left
      move_left(@ground_speed)
    end
    if b_down.include? controls.right
      move_right(@ground_speed)
    end
    if b_down.include? controls.down
      @state = :crouching
    end
  end

  def crouching_action(controls)
    b_down = controls.buttons_down
    if !b_down.include? controls.down
      @state = :standing
    end
    if b_down.include? controls.up
      start_jumpsquat
    end
  end

  def update(controls)
    if @state == :jumpsquat
      jumpsquat_action(controls)
    elsif @state == :jumping
      jumping_action(controls)
    elsif @state == :standing
      standing_action(controls)
    elsif @state == :crouching
      crouching_action(controls)
    end
  end
end
