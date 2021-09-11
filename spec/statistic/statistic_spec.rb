require "spec_helper"
require "wrf_library/statistic"

describe WrfLibrary::Statistic do

  describe "#calculate_timespan_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the air temperature" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2021-06-29 00:00 UTC"))
        means = WrfLibrary::Statistic.calculate_timespan_means(:air_temperature, handler, :day)
        expect(means.length).to eq(2)
        expect(means[0]).to eq(277.338)
        expect(means[1]).to eq(275.98)
      end
    end
  end

  describe "#calculate_timespan_rainsum" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the air temperature" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2021-06-29 00:00 UTC"))
        means = WrfLibrary::Statistic.calculate_timespan_rainsum(handler, :day)
        expect(means.length).to eq(2)
        expect(means[0]).to eq(0.001)
        expect(means[1]).to eq(0)
      end
    end
  end

  describe "#calculate_timespan_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the air temperature" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_HOUR, Time.parse("2021-06-29 00:00 UTC"))
        means = WrfLibrary::Statistic.calculate_timespan_means(:air_temperature, handler, :day)
        expect(means.length).to eq(1)
        expect(means[0]).to eq(273.616)
      end
    end
  end

  describe "#calculate_timespan_rainsum" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the air temperature" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_HOUR, Time.parse("2021-06-29 00:00 UTC"))
        means = WrfLibrary::Statistic.calculate_timespan_rainsum(handler, :day)
        expect(means.length).to eq(1)
        expect(means[0]).to eq(1.5)
      end
    end
  end

end
