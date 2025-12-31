require "spec_helper"
require "wrf_library/statistic"

describe WrfLibrary::Measurand::Wind do

  describe "#calculate_winddirection" do
    context "given the wind speed in its components u and v" do
      it "calculates the wind direction" do
        # [:W, :SW, :NW, :N, :N, -1, :S, :NE, :E, :SE]
        u = [1.0, 1.0,  0.5,  0.5,  0.0, 0.0, -0.5, -0.5, -1.0, -1.0]
        v = [0.0, 1.0, -0.5, -2.0, -1.0, 0.0,  2.0, -0.5,  0.0,  1.0]
        wind_direction = WrfLibrary::Measurand::Wind.calculate_winddirection(u, v)
        expect(wind_direction[0].round(1)).to eq(270.0)
        expect(wind_direction[1].round(1)).to eq(225.0)
        expect(wind_direction[2].round(1)).to eq(315.0)
        expect(wind_direction[3].round(1)).to eq(346.0)
        expect(wind_direction[4].round(1)).to eq(360.0)
        expect(wind_direction[5].round(1)).to eq(-1.0)
        expect(wind_direction[6].round(1)).to eq(166.0)
        expect(wind_direction[7].round(1)).to eq(45.0)
        expect(wind_direction[8].round(1)).to eq(90.0)
        expect(wind_direction[9].round(1)).to eq(135.0)
      end
    end
  end

end
