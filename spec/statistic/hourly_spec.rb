require "spec_helper"
require "wrf_library/statistic"

describe WrfLibrary::Statistic do

  describe "#generate_hourly_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the air temperature" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"))
        means = WrfLibrary::Statistic::Hourly.generate_hourly_means(:air_temperature, handler)
        expect(means.length).to eq(24)
        expect(means[0].round(3)).to eq(272.893)
        expect(means[23].round(3)).to eq(276.096)
      end
    end
  end

  describe "#generate_hourly_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the pressure" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"))
        means = WrfLibrary::Statistic::Hourly.generate_hourly_means(:pressure, handler)
        expect(means.length).to eq(24)
        expect(means[0].round(3)).to eq(102024.258)
        expect(means[23].round(3)).to eq(100990.472)
      end
    end
  end


end
