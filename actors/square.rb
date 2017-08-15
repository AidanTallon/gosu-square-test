class Square
  attr_reader :x, :y, :width, :height

  def initialize(x_pos, y_pos, width = 50, height = 50)
    @x = x_pos
    @y = y_pos
    @width = width
    @height = height
    @jump_height = 100
    @jumpsquat_length = 10
    @state = :grounded
    @ground_speed = 2
    @air_speed = 1

    @initial_vertical_velocity = 20
    @min_vertical_velocity = -20
    @current_vertical_velocity = 20
  end

  def draw
    if @state == :jumpsquat
      jumpsquat_draw
    else
      Gosu::draw_rect(@x, $window.height - @y - @height, @width, @height, Gosu::Color::WHITE)
    end
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

  def jumpsquat_action(controls)
    @active_jumpsquat -= 1
    if @active_jumpsquat <= 0
      @current_vertical_velocity = @initial_vertical_velocity
      @state = :jumping
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
      @state = :grounded
    end
  end

  def grounded_action(controls)
    b_down = controls.buttons_down
    if b_down.include? controls.up
      @state = :jumpsquat
      @active_jumpsquat = @jumpsquat_length
    end
    if b_down.include? controls.left
      move_left(@ground_speed)
    end
    if b_down.include? controls.right
      move_right(@ground_speed)
    end
  end

  def update(controls)
    if @state == :jumpsquat
      jumpsquat_action(controls)
    elsif @state == :jumping
      jumping_action(controls)
    elsif @state == :grounded
      grounded_action(controls)
    end
  end
end
