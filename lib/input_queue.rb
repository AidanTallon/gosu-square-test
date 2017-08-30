# TODO - general algorith to determine moves - get moves from a yaml file

class InputQueue
  attr_accessor :queue, :on_frame

  # what if timeout was handled in the check_queue method?
  # maybe only time difference between each input should be considered, instead of checking whoe queue or w/e
  BUTTON_TIMEOUT = 15

  def initialize(controls)
    @controls = controls
    @queue = []
    @moveset = YAML.load_file(File.new './moves.yml')
  end

  def update
    @queue.delete_if do |b|
      (b[1] -= 1) <= 0
    end
    #@on_frame = @controls.buttons_pressed_this_frame
    #@on_frame.each do |b|
    #  @queue << [b, BUTTON_TIMEOUT]
    #end
  end

  def button_down(id)
    @queue << [id, BUTTON_TIMEOUT]
  end

# TODO - different button timeouts for different moves???
  def check_queue
    q = @queue.reverse
    @moveset.each do |move_name, move_inputs|
      if q.first(move_inputs.length) == []
        break
      elsif q.first(move_inputs.length).map { |m| m[0] } == move_inputs.map { |m| @controls[m] }
        # stops dash occuring again after dash duration. wouldn't be needed if timeouts were specific to each move, however that might be more complex than it's worth
        @queue.pop(move_inputs.length)
        return move_name.to_sym
      end
    end
    return q[0][0] rescue nil
  end
end
