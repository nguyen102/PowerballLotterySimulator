require "optionparser"

class ArgParser
  def initialize args
    @options = {}
    initialize_parser
  end

  def parse args
    begin
      parse_user_input args
    rescue ArgumentError => e
      display_error_message e
      exit(1)
    end
    return @options
  end

  def initialize_parser 
    @optparse  = OptionParser.new do |o|
      o.banner = "Usage: Simulate Powerball Lottery"
      o.separator  ""
      o.separator  "Options"
      o.on(     '-N', "--number_of_simulated games", "Provide number of games you want simulated.") { |number| @options[:number_of_games] =  number}
      o.on_tail('-H', "--help"               , "Show this message") { puts o; exit }
    end
  end

  def parse_user_input args
    @optparse.parse!(args)
    if !all_required_values_entered?
      raise ArgumentError, get_error_message_for_missing_required_argument
    end
  end

  def all_required_values_entered?
    return !@options[:number_of_games].nil?
  end

  def get_error_message_for_missing_required_argument
    error_message = ""
    if @options[:number_of_games].nil?
      error_message += "Missing field value for number_of_games"
    end
    return error_message
  end

  def display_error_message error_message
    puts error_message
    puts @optparse
  end
  
end

