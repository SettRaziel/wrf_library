require "spec_helper"
require "wrf_library/json_converter"
require "fileutils"
require "time"

describe WrfLibrary::JsonConverter::HourlyJsonConverter do

  handler = WrfLibrary::Wrf::Handler.new(BERLIN_DATA_HOUR, Time.parse("2020-06-29 12:00 UTC"))
  converter = WrfLibrary::JsonConverter::HourlyJsonConverter.new(:rainsum, handler)

  describe ".convert" do
    context "given a meteogram output file" do
      it "read it and create the correct json output" do
        expect { converter.convert(__dir__) }.to raise_error(NotImplementedError)
      end
    end
  end

end
