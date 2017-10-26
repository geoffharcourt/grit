require "spec_helper"

RSpec.describe Grit::RbiOutcome do
  describe "#generate" do
    context "for a home run" do
      context "with the minumum random result" do
        it "returns 1" do
          stat_line = { tb: 4 }
          random_number_generator = instance_double(Random, rand: 0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the top of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { tb: 4 }
          random_number_generator = instance_double(Random, rand: 0.59)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the bottom of the 2-RBI threhold" do
        it "returns 2" do
          stat_line = { tb: 4 }
          random_number_generator = instance_double(Random, rand: 0.591)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(2)
        end
      end

      context "at the top of the 2-RBI threhold" do
        it "returns 2" do
          stat_line = { tb: 4 }
          random_number_generator = instance_double(Random, rand: 0.867)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(2)
        end
      end

      context "at the bottom of the 3-RBI threhold" do
        it "returns 3" do
          stat_line = { tb: 4 }
          random_number_generator = instance_double(Random, rand: 0.868)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(3)
        end
      end

      context "at the top of the 3-RBI threhold" do
        it "returns 3" do
          stat_line = { tb: 4 }
          random_number_generator = instance_double(Random, rand: 0.978)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(3)
        end
      end

      context "at the bottom of the 4-RBI threhold" do
        it "returns 4" do
          stat_line = { tb: 4 }
          random_number_generator = instance_double(Random, rand: 0.979)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(4)
        end
      end

      context "at the maximum random result" do
        it "returns 4" do
          stat_line = { tb: 4 }
          random_number_generator = instance_double(Random, rand: 1.0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(4)
        end
      end
    end

    context "for a triple" do
      context "with the minumum random result" do
        it "returns 0" do
          stat_line = { tb: 3 }
          random_number_generator = instance_double(Random, rand: 0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the top of the 0-RBI threhold" do
        it "returns 0" do
          stat_line = { tb: 3 }
          random_number_generator = instance_double(Random, rand: 0.575)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the bottom of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { tb: 3 }
          random_number_generator = instance_double(Random, rand: 0.576)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the top of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { tb: 3 }
          random_number_generator = instance_double(Random, rand: 0.829)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the bottom of the 2-RBI threhold" do
        it "returns 2" do
          stat_line = { tb: 3 }
          random_number_generator = instance_double(Random, rand: 0.830)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(2)
        end
      end

      context "at the top of the 2-RBI threhold" do
        it "returns 2" do
          stat_line = { tb: 3 }
          random_number_generator = instance_double(Random, rand: 0.955)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(2)
        end
      end

      context "at the bottom of the 3-RBI threhold" do
        it "returns 3" do
          stat_line = { tb: 3 }
          random_number_generator = instance_double(Random, rand: 0.956)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(3)
        end
      end

      context "at the maximum random result" do
        it "returns 3" do
          stat_line = { tb: 3 }
          random_number_generator = instance_double(Random, rand: 1.0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(3)
        end
      end
    end

    context "for a double" do
      context "with the minumum random result" do
        it "returns 0" do
          stat_line = { tb: 2 }
          random_number_generator = instance_double(Random, rand: 0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the top of the 0-RBI threhold" do
        it "returns 0" do
          stat_line = { tb: 2 }
          random_number_generator = instance_double(Random, rand: 0.685)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the bottom of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { tb: 2 }
          random_number_generator = instance_double(Random, rand: 0.686)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the top of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { tb: 2 }
          random_number_generator = instance_double(Random, rand: 0.914)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the bottom of the 2-RBI threhold" do
        it "returns 2" do
          stat_line = { tb: 2 }
          random_number_generator = instance_double(Random, rand: 0.915)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(2)
        end
      end

      context "at the top of the 2-RBI threhold" do
        it "returns 2" do
          stat_line = { tb: 2 }
          random_number_generator = instance_double(Random, rand: 0.991)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(2)
        end
      end

      context "at the bottom of the 3-RBI threhold" do
        it "returns 3" do
          stat_line = { tb: 2 }
          random_number_generator = instance_double(Random, rand: 0.992)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(3)
        end
      end

      context "at the maximum random result" do
        it "returns 3" do
          stat_line = { tb: 2 }
          random_number_generator = instance_double(Random, rand: 1.0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(3)
        end
      end
    end

    context "for a single" do
      context "with the minumum random result" do
        it "returns 0" do
          stat_line = { tb: 1 }
          random_number_generator = instance_double(Random, rand: 0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the top of the 0-RBI threhold" do
        it "returns 0" do
          stat_line = { tb: 1 }
          random_number_generator = instance_double(Random, rand: 0.818)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the bottom of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { tb: 1 }
          random_number_generator = instance_double(Random, rand: 0.819)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the top of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { tb: 1 }
          random_number_generator = instance_double(Random, rand: 0.974)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the bottom of the 2-RBI threhold" do
        it "returns 2" do
          stat_line = { tb: 1 }
          random_number_generator = instance_double(Random, rand: 0.975)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(2)
        end
      end

      context "at the top of the 2-RBI threhold" do
        it "returns 2" do
          stat_line = { tb: 1 }
          random_number_generator = instance_double(Random, rand: 0.999)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(2)
        end
      end

      context "at the bottom of the 3-RBI threhold" do
        it "returns 3" do
          stat_line = { tb: 1 }
          random_number_generator = instance_double(Random, rand: 0.9991)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(3)
        end
      end

      context "at the maximum random result" do
        it "returns 3" do
          stat_line = { tb: 1 }
          random_number_generator = instance_double(Random, rand: 1.0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(3)
        end
      end
    end

    context "for a hit-by-pitch" do
      context "with the minumum random result" do
        it "returns 0" do
          stat_line = { hbp: 1 }
          random_number_generator = instance_double(Random, rand: 0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the top of the 0-RBI threhold" do
        it "returns 0" do
          stat_line = { hbp: 1 }
          random_number_generator = instance_double(Random, rand: 0.976)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the bottom of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { hbp: 1 }
          random_number_generator = instance_double(Random, rand: 0.977)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the maximum random result" do
        it "returns 1" do
          stat_line = { hbp: 1 }
          random_number_generator = instance_double(Random, rand: 1.0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end
    end

    context "for a walk" do
      context "with the minumum random result" do
        it "returns 0" do
          stat_line = { bb: 1 }
          random_number_generator = instance_double(Random, rand: 0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the top of the 0-RBI threhold" do
        it "returns 0" do
          stat_line = { bb: 1 }
          random_number_generator = instance_double(Random, rand: 0.982)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the bottom of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { bb: 1 }
          random_number_generator = instance_double(Random, rand: 0.983)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the maximum random result" do
        it "returns 1" do
          stat_line = { bb: 1 }
          random_number_generator = instance_double(Random, rand: 1.0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end
    end

    context "for a contact-out, non-sacrifice" do
      context "with the minumum random result" do
        it "returns 0" do
          stat_line = { tb: 0 }
          random_number_generator = instance_double(Random, rand: 0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the maximum random result" do
        it "returns 0" do
          stat_line = { tb: 0 }
          random_number_generator = instance_double(Random, rand: 1.0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end
    end

    context "for a non-AB plate appearance" do
      context "with the minumum random result" do
        it "returns 0" do
          stat_line = { ab: 0, tb: 0 }
          random_number_generator = instance_double(Random, rand: 0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the top of the 0-RBI threhold" do
        it "returns 0" do
          stat_line = { ab: 0, tb: 0 }
          random_number_generator = instance_double(Random, rand: 0.410)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the bottom of the 1-RBI threhold" do
        it "returns 1" do
          stat_line = { ab: 0, tb: 0 }
          random_number_generator = instance_double(Random, rand: 0.411)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end

      context "at the maximum random result" do
        it "returns 1" do
          stat_line = { ab: 0, tb: 0 }
          random_number_generator = instance_double(Random, rand: 1.0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(1)
        end
      end
    end

    context "for a strikeout" do
      context "with the minumum random result" do
        it "returns 0" do
          stat_line = { ab: 1, k: 1 }
          random_number_generator = instance_double(Random, rand: 0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end

      context "at the maximum random result" do
        it "returns 0" do
          stat_line = { ab: 1, k: 1 }
          random_number_generator = instance_double(Random, rand: 1.0)
          allow(Random).to receive(:new).and_return(random_number_generator)

          result = described_class.new(stat_line).generate

          expect(result).to eq(0)
        end
      end
    end
  end
end
