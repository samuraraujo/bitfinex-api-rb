require "./bitfinex.rb"

client = Bitfinex::Client.new(2)
Thread.new {

  while (true) do
    begin
      sleep(10)
      puts "sending ping"
      client.ws_send({event: 'ping'})
      puts "sent"
      client.ws_close_all
    rescue Exception => e
      puts e
    end
  end
}
while true
  begin
    puts "RECONNECTING"
    client = Bitfinex::Client.new(2)
    client.listen_trades("BTCUSD") do |trade|
      puts trade.join(",") if trade.instance_of? Array
    end
    client.listen!
  rescue Exception => e
    puts e
    puts e.backtrace
  end
  sleep(3)
end
