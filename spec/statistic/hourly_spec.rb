require "spec_helper"
require "wrf_library/statistic"

describe WrfLibrary::Statistic do

  describe "#calculate_hourly_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the air temperature" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"))
        means = WrfLibrary::Statistic::Hourly.calculate_hourly_means(:air_temperature, handler)
        expect(means.length).to eq(25)
        expect(means[0]).to eq(272.893)
        expect(means[23]).to eq(276.096)
      end
    end
  end

  describe "#calculate_hourly_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the pressure" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"))
        means = WrfLibrary::Statistic::Hourly.calculate_hourly_means(:pressure, handler)
        expect(means.length).to eq(25)
        expect(means[0]).to eq(102024.258)
        expect(means[23]).to eq(100990.472)
      end
    end
  end

  describe "#calculate_hourly_windspeed_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the wind speed" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2021-06-29 12:00 UTC"))
        means = WrfLibrary::Statistic::Hourly.calculate_hourly_windspeed_means(handler)
        expect(means.length).to eq(25)
        expect(means[0]).to eq(2.855)
        expect(means[23]).to eq(3.021)
      end
    end
  end

  describe "#calculate_hourly_winddirection_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the prevalent wind direction" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2021-06-29 12:00 UTC"))
        directions = WrfLibrary::Statistic::Hourly.calculate_hourly_winddirection_means(handler)
        expect(directions.length).to eq(25)
        expect(directions[0]).to eq(:SW)
        expect(directions[23]).to eq(:W)
      end
    end
  end

  describe "#calculate_hourly_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the air temperature" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_HOUR, Time.parse("2019-06-29 12:00 UTC"))
        means = WrfLibrary::Statistic::Hourly.calculate_hourly_means(:air_temperature, handler)
        expect(means.length).to eq(7)
        expect(means[0]).to eq(273.3)
        expect(means[6]).to eq(273.5)
      end
    end
  end

  describe "#calculate_hourly_rainsum" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the precipitation" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_HOUR, Time.parse("2019-06-29 12:00 UTC"))
        means = WrfLibrary::Statistic::Hourly.calculate_hourly_rainsum(handler)
        expect(means.length).to eq(7)
        expect(means[0]).to eq(0.4)
        expect(means[5]).to eq(0.2)
      end
    end
  end

  describe "#calculate_hourly_windspeed_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the wind speed" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_HOUR, Time.parse("2021-06-29 12:00 UTC"))
        means = WrfLibrary::Statistic::Hourly.calculate_hourly_windspeed_means(handler)
        expect(means.length).to eq(7)
        expect(means[0]).to eq(3.006)
        expect(means[5]).to eq(3.006)
      end
    end
  end

  describe "#calculate_hourly_winddirection_means" do
    context "given a handler with data of a wrf forecast" do
      it "calculate the hourly values for the prevalent wind direction" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_HOUR, Time.parse("2021-06-29 12:00 UTC"))
        directions = WrfLibrary::Statistic::Hourly.calculate_hourly_winddirection_means(handler)
        expect(directions.length).to eq(7)
        expect(directions[0]).to eq(:SW)
        expect(directions[5]).to eq(:SW)
      end
    end
  end

end
