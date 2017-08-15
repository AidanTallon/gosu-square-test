class Controls
  def initialize(controls_dict)
    @controls = controls_dict
  end

  def [](key_name)
    @controls[key_name]
  end

  def method_missing(name, *args, &block)
    @controls[name.to_s].nil? ? super : @controls[name.to_s]
  end

  def respond_to_missing?(name, include_private = false)
    @controls[name.to_s].nil? ? super : true
  end

  def buttons_down
    buttons = []
    @controls.each do |c, v|
      buttons << v if $window.button_down? v
    end
    return buttons
  end
end
