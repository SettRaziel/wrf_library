require "spec_helper"
require "wrf_library/json_converter"

describe WrfLibrary::JsonConverter::BaseStationJsonConverter do

  describe ".add_additions" do
    context "given a meteogram output file" do
      it "initialize converter and fail when calling abstract method" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.parse("2020-06-29 12:00 UTC"))
        converter = WrfLibrary::JsonConverter::BaseStationJsonConverter.new(handler.data_repository)
        expect { 
          converter.send(:add_additions)
        }.to raise_error(NotImplementedError)
      end
    end
  end

  describe ".generate_data_values" do
    context "given a meteogram output file" do
      it "initialize converter and fail when calling abstract method" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.parse("2020-06-29 12:00 UTC"))
        converter = WrfLibrary::JsonConverter::BaseStationJsonConverter.new(handler.data_repository)
        expect { 
          converter.send(:generate_data_values)
        }.to raise_error(NotImplementedError)
      end
    end
  end

  describe ".convert" do
    context "given a meteogram output file inside convert" do
      it "initialize converter and fail when calling abstract method inside convert" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.parse("2020-06-29 12:00 UTC"))
        converter = WrfLibrary::JsonConverter::BaseStationJsonConverter.new(handler.data_repository)
        expect { 
          converter.convert(".")
        }.to raise_error(NotImplementedError)
      end
    end
  end

  describe ".convert" do
    context "given a meteogram output file" do
      it "initialize converter and fail when calling abstract method inside convert" do
        handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_SMALL, Time.parse("2020-06-29 12:00 UTC"))
        converter = WrfLibrary::JsonConverter::BaseStationJsonConverter.new(handler.data_repository)
        expect { 
          converter.convert()
        }.to raise_error(NotImplementedError)
      end
    end
  end

end
