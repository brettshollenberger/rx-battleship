require "active_record"
require "pry"

Dir[File.expand_path(File.join(__FILE__, "../lib/**/*.rb"))].each { |f| require f }

use BattleshipApp::SocketMiddleware do
  def on_message(ws, event)
    puts "Message received #{event.data}"
  end
end

run BattleshipApp
