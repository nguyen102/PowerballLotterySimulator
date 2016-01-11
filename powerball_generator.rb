class PowerballGenerator
  def get_random_number
    return rand(1..69)
  end

  def get_random_red_ball
    return rand(1..26)
  end

  def get_random_ball turn
    ball = get_random_number 
    (0..(turn - 2)).each do |prev_ball_index|
      if ball == @powerballs[prev_ball_index]
        ball = get_random_ball turn
        break
      end
    end
    return ball
  end


  def generate
    @powerballs = []
    @powerballs << get_random_number
    (2..5).each do |turn|
      @powerballs << get_random_ball(turn)
    end
    return @powerballs, get_random_red_ball
  end
end
