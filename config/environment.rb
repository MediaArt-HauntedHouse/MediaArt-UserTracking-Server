# Load the Rails application.
require File.expand_path('../application', __FILE__)

class Logger::FormatWithTime < Logger::Formatter
  # cattr_accessor(:datetime_format) { "%Y%m%d%H%m%S" }
  def call(severity, timestamp, progname, msg)
    # "[#{timestamp.strftime(datetime_format)}.#{'%06d' % timestamp.usec.to_s}] (pida=#{$$}) #{severity} -- : #{String === msg ? msg : msg.inspect}\n"
    "#{severity.ljust(6)}: #{String === msg ? msg : msg.inspect}\n"
  end
end

# Initialize the Rails application.
Rails.application.initialize!
