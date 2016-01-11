require_relative 'balls_result'
class PowerballGenerator
  def get_random_number
    return rand(1..69)
  end

  def get_powerball
    return rand(1..26)
  end

  def get_white_ball turn
    ball = get_random_number 
    (0..(turn - 2)).each do |prev_ball_index|
      if ball == @white_balls[prev_ball_index]
        ball = get_white_ball turn
        break
      end
    end
    return ball
  end


  def generate
    @white_balls = []
    @white_balls << get_random_number
    (2..5).each do |turn|
      @white_balls << get_white_ball(turn)
    end
    balls_result = BallsResult.new(@white_balls, get_powerball)
    return balls_result
  end
end
