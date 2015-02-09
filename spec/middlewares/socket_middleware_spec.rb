require "spec_helper"

describe BattleshipApp::SocketMiddleware do
  let(:middleware) { BattleshipApp::SocketMiddleware.new("") }

  before(:each) do
    @socket = middleware.initialize_socket
  end

  it "initializes sockets" do
    ws = middleware.initialize_socket()

    expect(ws.class).to be BattleshipApp::SocketMiddleware::Websocket
  end
end
