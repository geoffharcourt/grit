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
      }
    end

    context "when the event is under the hit threshold" do
      it "generates a hit result" do
        random_number_generator = instance_double(Random, rand: 0.25)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1))
      end

      it "recognizes a single" do
        random_number_generator = instance_double(Random, rand: 0.12)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1, tb: 1))
      end

      it "recognizes a double" do
        random_number_generator = instance_double(Random, rand: 0.20)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1, tb: 2))
      end

      it "recognizes a triple" do
        random_number_generator = instance_double(Random, rand: 0.21)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1, tb: 3))
      end

      it "recognizes a home run" do
        random_number_generator = instance_double(Random, rand: 0.25)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 1, h: 1, tb: 4, hr: 1))
      end
    end

    context "when the event between zero and the walk threshold" do
      it "generates a BB result" do
        random_number_generator = instance_double(Random, rand: 0.50)

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
        random_number_generator = instance_double(Random, rand: 0.51)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 0, hbp: 1))
      end
    end

    context "when the event is between the HBP threshold and the non-AB pa out threshold" do
      it "generates a HBP result" do
        random_number_generator = instance_double(Random, rand: 0.52)

        simulator = Grit.new(
          stat_line: stat_line,
          random_number_generator: random_number_generator,
        )

        expect(simulator.generate_simulated_plate_appearance).
          to match(a_hash_including(ab: 0, h: 0, bb: 0, hbp: 0))
      end
    end
  end
end