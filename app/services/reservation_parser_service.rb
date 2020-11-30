class ReservationParserService
  attr_accessor :parser, :params

  UNPARSABLE_RESPONSE = {
    message: 'Unable to parse json.'
  }.freeze

  def self.parsers
    [
      ReservationParserService::Service1::Parser,
      ReservationParserService::Service2::Parser
    ]
  end

  def initialize(params)
    @params = params
    @parser = ReservationParserService.parsers.find { |parser| parser.parseable?(params) }
  end

  def call
    return false unless parser

    parser.new(params).parse!
  end
end
