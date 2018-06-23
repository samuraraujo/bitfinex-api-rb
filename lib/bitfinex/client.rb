module Bitfinex
  class Client

    attr_accessor :api_endpoint, :debug, :debug_connection, :secret
    attr_accessor :api_key, :websocket_api_endpoint, :rest_timeout
    attr_accessor :reconnect, :reconnect_after, :rest_open_timeout
    attr_accessor :api_version
    include Bitfinex::RestConnection
    include Bitfinex::WebsocketConnection
    include Bitfinex::AuthenticatedConnection
    include Bitfinex::Configurable


    def initialize(api_version=1)
      @api_version = api_version

      debug = false
      reconnect = true
      reconnect_after = 60
      rest_timeout = 30
      rest_open_timeout = 30
      debug_connection = false

      if @api_version == 1

         api_endpoint = "https://api.bitfinex.com/v1/"
         websocket_api_endpoint = "wss://api.bitfinex.com/ws"

         api_version = 1

        extend Bitfinex::V1::TickerClient
        extend Bitfinex::V1::TradesClient
        extend Bitfinex::V1::FundingBookClient
        extend Bitfinex::V1::OrderbookClient
        extend Bitfinex::V1::StatsClient
        extend Bitfinex::V1::LendsClient
        extend Bitfinex::V1::SymbolsClient
        extend Bitfinex::V1::AccountInfoClient
        extend Bitfinex::V1::DepositClient
        extend Bitfinex::V1::OrdersClient
        extend Bitfinex::V1::PositionsClient
        extend Bitfinex::V1::HistoricalDataClient
        extend Bitfinex::V1::MarginFundingClient
        extend Bitfinex::V1::WalletClient
      else

        api_endpoint = "https://api.bitfinex.com/v2/"
        websocket_api_endpoint = "wss://api.bitfinex.com/ws/2/"
        extend Bitfinex::V2::TickerClient
        extend Bitfinex::V2::StatsClient
        extend Bitfinex::V2::UtilsClient
        extend Bitfinex::V2::PersonalClient
        extend Bitfinex::V2::TradingClient
        extend Bitfinex::V2::MarginClient
      end

      @mutex = Mutex.new
      @c_counter = 1
    end
  end
end
