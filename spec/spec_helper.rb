require "pry"
require "pry-byebug"
require "rspec"

Dir[File.expand_path(File.join(__FILE__, "../../lib/**/*.rb"))].each  { |f| require f }
Dir[File.expand_path(File.join(__FILE__, "../support/**/*.rb"))].each { |f| require f }
