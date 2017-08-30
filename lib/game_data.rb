class GameData
  attr_reader :data, :characters

  def initialize(data_yaml_path, char_yaml_path)
    @data = YAML.load File.new(data_yaml_path)
    @characters = YAML.load File.new(char_yaml_path)
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
