require "grit/version"
require "grit/rbi_outcome"

class Grit
  def initialize(random_number_generator:, stat_line:, bump: 0.0)
    @random_number_generator = random_number_generator
    @stat_line = stat_line
    @bump = bump
  end

  def generate_simulated_plate_appearance
    batting_line_outcome.
      merge(run_outcome).
      merge(rbi: rbi).
      merge(baserunning_outcome)
  end

  private

  attr_reader :bump, :random_number_generator, :stat_line

  def baserunning_outcome
    @_baserunning_outcome ||=
      if batting_line_outcome[:tb] == 1 ||
        batting_line_outcome[:bb] == 1 ||
        batting_line_outcome[:hbp] == 1

        case random_number_generator.rand
        when 0..sb_outcome
          { sb: 1, cs: 0 }
        when 0..(sb_outcome + cs_outcome)
          { sb: 0, cs: 1 }
        else
          { sb: 0, cs: 0 }
        end
      else
        { sb: 0, cs: 0 }
      end
  end

  def sb_outcome
    stat_line[:sb].to_f / one_base_events
  end

  def cs_outcome
    stat_line[:cs].to_f / one_base_events
  end

  def one_base_events
    @_one_base_events ||=
      stat_line[:h] -
      stat_line[:h_2b] -
      stat_line[:h_3b] -
      stat_line[:hr] +
      stat_line[:bb] +
      stat_line[:hbp]
  end

  def batting_line_outcome
    @_batting_line_outcome ||=
      case random_event
      when -1..h_1b_rate
        { ab: 1, h: 1, tb: 1 }
      when 0..(h_1b_rate + h_2b_rate)
        { ab: 1, h: 1, tb: 2 }
      when 0..(h_1b_rate + h_2b_rate + h_3b_rate)
        { ab: 1, h: 1, tb: 3 }
      when home_run_range
        { ab: 1, h: 1, tb: 4, hr: 1, r: 1 }
      when 0..(h_rate + bb_rate)
        { ab: 0, bb: 1, tb: 0 }
      when 0..on_base_percentage
        { ab: 0, hbp: 1, tb: 0 }
      when 0..(on_base_percentage + non_ab_out_rate)
        { ab: 0, bb: 0, h: 0, hbp: 0, tb: 0 }
      else
        { ab: 1, r: 0, tb: 0 }
      end
  end

  def home_run_range
    (h_1b_rate + h_2b_rate + h_3b_rate)..(h_1b_rate + h_2b_rate + h_3b_rate + hr_rate)
  end

  def rbi
    @_rbi ||= Grit::RbiOutcome.new(batting_line_outcome, bump).generate
  end

  def total_bases
    @_total_bases ||= batting_line_outcome.fetch(:tb, 0)
  end

  def run_outcome
    case random_event
    when home_run_range
      { r: 1 }
    when 0..on_base_percentage
      { r: run_value }
    else
      { r: 0 }
    end
  end

  def run_value
    @_run_value ||= if random_number_generator.rand + bump < run_threshold
      1
    else
      0
    end
  end

  def run_threshold
    @_run_threhsold ||= (
      stat_line[:r] - stat_line[:hr]
    ) / (
      times_on_base - stat_line[:hr]
    ).to_f
  end

  def times_on_base
    @_times_on_base ||= stat_line[:h] + stat_line[:bb] + stat_line[:hbp]
  end

  def random_event
    @_random_event ||= random_number_generator.rand
  end

  def stat_line_pa
    @_stat_line_pa ||= stat_line[:pa].to_f
  end

  def on_base_percentage
    times_on_base / stat_line_pa
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
