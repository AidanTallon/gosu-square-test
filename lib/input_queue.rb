class InputQueue
  attr_accessor :queue, :on_frame

  BUTTON_TIMEOUT = 10

  def initialize(controls)
    @controls = controls
    @queue = []
  end

  def update
    @queue.delete_if do |b|
      (b[1] -= 1) <= 0
    end
    @on_frame = @controls.buttons_pressed_this_frame
    @on_frame.each do |b|
      @queue << [b, BUTTON_TIMEOUT]
    end
  end

  def check_for(move)
    if move == :dash
      return check_for_dash
    end
  end

  def check_for_dash
    if @on_frame.include? @controls.left or @on_frame.include? @controls.right
      just_inputs = @queue.map { |k| k[0] }
      multiple_inputs = just_inputs.select { |k| just_inputs.count(k) > 1 }
      if multiple_inputs.include? @controls.left or multiple_inputs.include? @controls.right
        return true
      end
    end
  end
end
