class Grit::RbiOutcome
  def initialize(stat_line, bump)
    @stat_line = stat_line
    @bump = bump
  end

  def generate
    return 0 if stat_line.fetch(:k, 0) == 1
    case random_number + (0.10 * bump)
    when zero_rbi_range(tb)
      then 0
    when one_rbi_range(tb)
      then 1
    when two_rbi_range(tb)
      then 2
    when three_rbi_range(tb)
      then 3
    else 4
    end
  end

  private

  attr_reader :bump, :stat_line

  def tb
    return 5 if stat_line.fetch(:hbp, 0) == 1
    return 6 if stat_line.fetch(:bb, 0) == 1
    return 7 if stat_line.fetch(:ab, 1) == 0
    @_tb ||= stat_line[:tb]
  end

  def random_number
    @_random_number ||= Random.new.rand
  end

  def zero_rbi_range(bases)
    [-1..1.0, -1..0.818, -1..0.685, -1..0.575, 1.1, -1..0.976, -1..0.982, -1..0.410][bases]
  end

  def one_rbi_range(bases)
    [-1, 0.818..0.974, 0.685..0.914, 0.575..0.829, 0..0.59, 0.976..1.0, 0.982..1.0, 0.410..1.0][bases]
  end

  def two_rbi_range(bases)
    [-1, 0.974..0.999, 0.914..0.991, 0.829..0.955, 0.59..0.867][bases]
  end

  def three_rbi_range(bases)
    [-1, 0.999..(1.0 + bump), 0.991..(1.0 + bump), 0.955..(1.0 + bump), 0.867..(0.978 + bump)][bases]
  end
end
