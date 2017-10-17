require "grit/version"

class Grit
  def initialize(random_number_generator:, stat_line:)
    @random_number_generator = random_number_generator
    @stat_line = stat_line
  end

  def generate_simulated_plate_appearance
    case random_event
    when 0..h_1b_rate
      { ab: 1, h: 1, tb: 1 }
    when h_1b_rate..(h_1b_rate + h_2b_rate)
      { ab: 1, h: 1, tb: 2 }
    when (h_1b_rate + h_2b_rate)..(h_1b_rate + h_2b_rate + h_3b_rate)
      { ab: 1, h: 1, tb: 3 }
    when (h_1b_rate + h_2b_rate + h_3b_rate)..(h_1b_rate + h_2b_rate + h_3b_rate + hr_rate)
      { ab: 1, h: 1, tb: 4, hr: 1 }
    when h_rate..(h_rate + bb_rate)
      { ab: 0, bb: 1 }
    when (h_rate + bb_rate)..(h_rate + bb_rate + hbp_rate)
      { ab: 0, hbp: 1 }
    when on_base_percentage..(on_base_percentage + non_ab_out_rate)
      { ab: 0, bb: 0, h: 0, hbp: 0 }
    else
      {}
    end
  end

  private

  attr_reader :random_number_generator, :stat_line

  def random_event
    @_random_event = random_number_generator.rand
  end

  def stat_line_pa
    @_stat_line_pa ||= stat_line[:pa].to_f
  end

  def on_base_percentage
    (stat_line[:bb] + stat_line[:h] + stat_line[:hbp]) / stat_line_pa
  end

  def bb_rate
    stat_line[:bb].to_f / stat_line_pa
  end

  def h_rate
    stat_line[:h].to_f / stat_line_pa
  end

  def h_1b_rate
    (
      stat_line[:h].to_i -
        stat_line[:h_2b].to_i -
        stat_line[:h_3b].to_i -
        stat_line[:hr].to_i
    ) / stat_line_pa
  end

  def h_2b_rate
    stat_line[:h_2b].to_f / stat_line_pa
  end

  def h_3b_rate
    stat_line[:h_3b].to_f / stat_line_pa
  end

  def hr_rate
    stat_line[:hr].to_f / stat_line_pa
  end

  def hbp_rate
    stat_line[:hbp].to_f / stat_line_pa
  end

  def non_ab_out_rate
    (stat_line[:pa] - stat_line[:ab] - stat_line[:bb] - stat_line[:hbp]) /
      stat_line_pa
  end
end
