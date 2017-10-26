RSpec.describe Grit do
  it "has a version number" do
    expect(Grit::VERSION).not_to be nil
  end

  describe "#generate_simulated_plate_appearance" do
    def stat_line
      {
        pa: 100,
        ab: 73,
        h: 25,
        h_2b: 7,
        h_3b: 1,
        hr: 4,
        bb: 25,
        hbp: 1,
        r: 20,
        rbi: 25,
        sb: 10,
        cs: 4,
      }
    end

    context "when the event is under the hit threshold" do
      it "generates a hit result" do
        random_number_generator = instance_double(Random, rand: hit_threshold)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1))
      end

      it "generates a single result" do
        random_number_generator = instance_double(Random, rand: single_threshold)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1, tb: 1))
      end

      it "generates a double result" do
        random_number_generator = instance_double(Random, rand: double_threshold)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1, tb: 2))
      end

      it "generates a triple result" do
        random_number_generator = instance_double(Random, rand: triple_threshold)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1, tb: 3))
      end

      it "generates a home run result" do
        random_number_generator = instance_double(Random, rand: home_run_threshold)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1, tb: 4, hr: 1, r: 1, rbi: a_value_between(1, 4)))
      end
    end

    describe "RBI generation" do
      it "returns an RBI result based on the stat line" do
        random_number_generator = instance_double(Random)
        rbi_generator = instance_double(Grit::RbiOutcome, generate: 3)
        allow(Grit::RbiOutcome).to receive(:new).and_return(rbi_generator)
        allow(random_number_generator).to receive(:rand).and_return(1.0, 0.34)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(rbi: 3))
      end
    end

    context "when there's a non-base-reaching event" do
      it "does not generate an R result" do
        random_number_generator = instance_double(Random)
        allow(random_number_generator).to receive(:rand).and_return(1.0, 0.34)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, r: 0))
      end

      it "does not generate an SB or CS result" do
        random_number_generator = instance_double(Random)
        allow(random_number_generator).to receive(:rand).and_return(1.0, 0.0)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(sb: 0, cs: 0))
      end
    end

    context "when there's an on-base event" do
      context "and the event starts on first base" do
        context "and the threshold is within an SB event" do
          it "generates an SB outcome" do
            random_number_generator = instance_double(Random)
            allow(random_number_generator).
              to receive(:rand).
              and_return(single_threshold, 0.25)

            simulator = Grit.new(
              stat_line: stat_line,
              random_number_generator: random_number_generator,
            )

            expect(simulator.generate_simulated_plate_appearance).
              to match(a_hash_including(sb: 1, cs: 0))
          end
        end

        context "and the threshold is above an SB event but under a CS event" do
          it "generates a CS outcome" do
            random_number_generator = instance_double(Random)
            allow(random_number_generator).
              to receive(:rand).
              and_return(single_threshold, 0.26)

            simulator = Grit.new(
              stat_line: stat_line,
              random_number_generator: random_number_generator,
            )

            expect(simulator.generate_simulated_plate_appearance).
              to match(a_hash_including(sb: 0, cs: 1))
          end
        end

        context "and the threshold is above a CS event" do
          it "does not generate an SB or CS outcome" do
            random_number_generator = instance_double(Random)
            allow(random_number_generator).
              to receive(:rand).
              and_return(single_threshold, 0.36)

            simulator = Grit.new(
              stat_line: stat_line,
              random_number_generator: random_number_generator,
            )

            expect(simulator.generate_simulated_plate_appearance).
              to match(a_hash_including(sb: 0, cs: 0))
          end
        end
      end

      context "and the event starts with an extra-base hit" do
        it "does not generate an SB or CS outcome" do
          random_number_generator = instance_double(Random)
          allow(random_number_generator).
            to receive(:rand).
            and_return(double_threshold, 0)

          simulator = Grit.new(
            stat_line: stat_line,
            random_number_generator: random_number_generator,
          )

          expect(simulator.generate_simulated_plate_appearance).
            to match(a_hash_including(sb: 0, cs: 0))
        end
      end

      context "and the event is run-scoring" do
        it "generates an R result" do
          random_number_generator = instance_double(Random)
          allow(random_number_generator).to receive(:rand).and_return(0.0, 0.34)

          simulator = Grit.new(
            stat_line: stat_line,
            random_number_generator: random_number_generator,
          )

          expect(simulator.generate_simulated_plate_appearance).
            to match(a_hash_including(r: 1))
        end
      end

      context "and the event is not run-scoring" do
        it "does not generate an R result" do
          random_number_generator = instance_double(Random)
          allow(random_number_generator).to receive(:rand).and_return(1.0, 0.35)

          simulator = Grit.new(
            stat_line: stat_line,
            random_number_generator: random_number_generator,
          )

          expect(simulator.generate_simulated_plate_appearance).
            to match(a_hash_including(r: 0))
        end
      end
    end

    context "when the event between zero and the walk threshold" do
      it "generates a BB result" do
        random_number_generator = instance_double(Random, rand: bb_threshold)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 0, bb: 1))
      end
    end

    context "when the event is between the walk threshold and the HBP threshold" do
      it "generates a HBP result" do
        random_number_generator = instance_double(Random, rand: hbp_threshold)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 0, hbp: 1))
      end
    end

    context "when the event is between the HBP threshold and the non-AB pa out threshold" do
      it "generates a PA, non-AB result" do
        random_number_generator = instance_double(Random, rand: non_ab_out_threshold)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 0, h: 0, bb: 0, hbp: 0))
      end
    end
  end

  def single_threshold
    0.12
  end

  def double_threshold
    single_threshold + 0.08
  end

  def triple_threshold
    double_threshold + 0.01
  end

  def home_run_threshold
    triple_threshold + 0.04
  end

  def hit_threshold
    home_run_threshold
  end

  def bb_threshold
    hit_threshold + 0.25
  end

  def hbp_threshold
    bb_threshold + 0.01
  end

  def non_ab_out_threshold
    hbp_threshold + 0.01
  end
end
