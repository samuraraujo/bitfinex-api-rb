require "./bitfinex.rb"
client = Bitfinex::Client.new(2)
Thread.abort_on_exception = true
client = Bitfinex::Client.new(2)
Thread.new {

  while (true) do
    begin
      sleep(25)
      if !client.is_open?
        puts "not open"
        # next
      end

      puts "sending ping"
      client.ws_send({event: 'ping'})
      puts "sent"
      client.ws_close_all
      sleep(2)
      client.ws_close_all
    rescue Exception => e
      puts "ERROR2"
      puts e
      client.ws_close_all
    end
  end
}
while true
  begin
    puts "RECONNECTING"
    client = Bitfinex::Client.new(2)
    client.listen_trades("BTCUSD") do |trade|
      if trade.instance_of? Array
      puts trade.join(",")
      else
        puts trade
        end
    end
    client.listen!

  rescue Exception => e

    puts "ERROR1"
    puts e
    puts e.backtrace
  end
   sleep(5)
end
