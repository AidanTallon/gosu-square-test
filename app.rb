require 'gosu'
require 'singleton'
require 'yaml'

Dir['./lib/*.rb'].each { |f| require f }
Dir['./scenes/*.rb'].each { |f| require f }
Dir['./actors/*.rb'].each { |f| require f }
Dir['./actors/states/*.rb'].each { |f| require f }

$config = Config.new './config.yml'
$gameData = GameData.new './data.yml', './characters.yml'

$window = MainWindow.new

$window.show
