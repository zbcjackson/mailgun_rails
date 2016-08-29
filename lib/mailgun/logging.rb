require 'log4r'

module Mailgun
  module Logging
    def self.initialize_logger
      @logger = Log4r::Logger.new 'Mailgun'
      formatter = Log4r::PatternFormatter.new pattern: "[%l] %d :: %m"
      @logger.outputters << Log4r::StdoutOutputter.new('console', formatter: formatter)
      # @logger.level = Log4r::INFO
      @logger
    end

    def self.logger
      defined?(@logger) ? @logger : initialize_logger
    end

    def self.logger=(log)
      @logger = log
    end

    def logger
      Mailgun::Logging.logger
    end
  end
end