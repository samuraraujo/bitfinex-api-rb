require "./bitfinex.rb"
client = Bitfinex::Client.new(2)
client.listen_trades("BTCUSD") do |trade|
  puts trade
end

Thread.new {

  while (true) do
    begin
      sleep(5)
      puts "sending ping"
      client.ws_send({event: 'ping'})
      puts "sent"
      client.ws_close_all
    rescue Exception => e
      puts e
    end
  end
}
client.listen!