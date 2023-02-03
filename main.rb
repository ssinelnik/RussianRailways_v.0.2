# ---------- modules ----------
require_relative 'modules/instance_counter'
require_relative 'modules/validate'
require_relative 'modules/manufacturer'

# ---------- classes ----------
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'main_menu'

MainMenu.new.start