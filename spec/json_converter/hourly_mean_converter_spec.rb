require "spec_helper"
require "wrf_library/json_converter"
require "fileutils"
require "time"

describe WrfLibrary::JsonConverter::HourlyMeanJsonConverter do

  handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_HOUR, Time.parse("2021-06-29 12:00 UTC"))

  describe ".convert" do
    context "given a meteogram output file" do
      it "read it and create the correct json output" do
        converter = WrfLibrary::JsonConverter::HourlyMeanJsonConverter.new(:air_temperature, handler)
        converter.convert(__dir__)
        expect(FileUtils.compare_file(File.join(__dir__,"output.json"), File.join(__dir__,"expected_hourly_mean_temperature.json"))).to be_truthy

        # clean up data from the test and catch errors since they should not let the test fail
        File.delete(File.join(__dir__,"output.json"))
      end
    end
  end

  describe ".convert" do
    context "given a meteogram output file" do
      it "read it and create the correct json output" do
        converter = WrfLibrary::JsonConverter::HourlyMeanJsonConverter.new(:air_temperature, handler)
        expect(converter.convert().empty?).to be_falsey 
      end
    end
  end


  describe ".convert" do
    context "given a meteogram output file" do
      it "read it and create the correct json output" do
        converter = WrfLibrary::JsonConverter::HourlyMeanJsonConverter.new(:pressure, handler)
        converter.convert(__dir__)
        expect(FileUtils.compare_file(File.join(__dir__,"output.json"), File.join(__dir__,"expected_hourly_mean_pressure.json"))).to be_truthy

        # clean up data from the test and catch errors since they should not let the test fail
        File.delete(File.join(__dir__,"output.json"))
      end
    end
  end

end
