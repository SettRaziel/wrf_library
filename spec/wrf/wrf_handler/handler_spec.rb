require "spec_helper"
require "time"

describe WrfLibrary::Wrf::Handler do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have data in the repository" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"))
        expect(handler.data_repository.repository).to be_truthy
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have 994 entries in the repository" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"))
        expect(handler.data_repository.repository.size).to eq(994)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and check for correct temperature values" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"))
        temperature_values = handler.retrieve_data_set(:air_temperature)
        expect(temperature_values[0].round(3)).to eq(273.677)
        expect(temperature_values[4].round(3)).to eq(273.302)
      end
    end
  end

    describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and try to get not available data" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"))
        expect {
          handler.retrieve_data_set(:something)
        }.to raise_error(ArgumentError)
      end
    end
  end


  describe ".new" do
    context "given a meteogram output file, the date and a duration" do
      it "read the file and have 477 entries in the repository" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"), 12.0)
        expect(handler.data_repository.repository.size).to eq(477)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file, the date, a duration and an offset" do
      it "read the file and have 507 entries in the repository starting with the correct temperature and timestamps" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA, Time.parse("2019-06-29 12:00 UTC"), 12.0, 6.0)
        expect(handler.data_repository.repository.size).to eq(507)
        temperature_values = handler.retrieve_data_set(:air_temperature)
        forecast_time = handler.retrieve_data_set(:forecast_time)
        expect(temperature_values[0].round(3)).to eq(271.113)
        expect(temperature_values.last.round(3)).to eq(280.919)
        expect(forecast_time[0]).to eq(Time.parse("2019-06-29 18:00 UTC"))
        expect(forecast_time.last).to eq(Time.parse("2019-06-30 06:00 UTC"))
      end
    end
  end

end
