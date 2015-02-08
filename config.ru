Dir[File.expand_path(File.join(__FILE__, "../app/**/*.rb"))].each { |f| require f }

use BattleshipApp::SocketMiddleware

run BattleshipApp
