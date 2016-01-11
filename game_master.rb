require_relative 'powerball_generator'
require_relative 'arg_parser'
require_relative 'balls_result'
class GameMaster
  def initialize args
    @powerball_generator = PowerballGenerator.new
    arg_parser = ArgParser.new args
    @number_of_games = arg_parser.parse(args)[:number_of_games].to_i
  end

  def run
    wins = 0
    (1..@number_of_games).each do |game|
      wins += 1 if win_a_game?
    end 
    puts "Won #{wins} times out of #{@number_of_games}"
    winning_percent = wins / @number_of_games.to_f * 100 
    puts "Winning percent: #{winning_percent.round(2)}%"
  end

  def win_a_game?
    player_balls_result, actual_balls_result = play_a_game
    return match(player_balls_result, actual_balls_result)
  end

  def play_a_game
    player_balls_result = @powerball_generator.generate
    actual_balls_result = @powerball_generator.generate
    #puts "Player white_balls #{player_white_balls}"
    #puts "Actual white_balls #{actual_white_balls}"
    return player_balls_result, actual_balls_result 
  end

  def match player_balls_result, actual_balls_result 
    intersection = player_balls_result.white_balls & actual_balls_result.white_balls
    if match_one_ball(intersection) && player_balls_result.powerball == actual_balls_result.powerball       
      #puts "MATCHED: #{intersection.inspect}"
      return true
    end
    return false
  end

  def match_four_balls intersection
    return intersection.length == 4
  end

  def match_three_ball intersection
    return intersection.length == 3
  end

  def match_two_ball intersection
    return intersection.length == 2
  end

  def match_one_ball intersection
    return intersection.length == 1
  end

  def match_atleast_one_ball intersection
    return !intersection.empty?
  end
end

game_master = GameMaster.new ARGV
game_master.run 
