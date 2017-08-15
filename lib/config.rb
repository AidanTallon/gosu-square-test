class Config
  attr_reader :data

  def initialize(yaml_path)
    @data = YAML.load File.new(yaml_path)
  end

  def [](key_name)
    @data[key_name]
  end

  def method_missing(name, *args, &block)
    @data[name.to_s].nil? ? super : @data[name.to_s]
  end

  def respond_to_missing?(name, include_private = false)
    @data[name.to_s].nil? ? super : true
  end
end
