#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-05 20:42:51
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-11-15 20:07:20

require "spec_helper"
require "wrf_library/json_converter"
require "fileutils"
require "time"

describe WrfLibrary::JsonConverter::WrfJsonConverter do

  handler = WrfLibrary::Wrf::Handler.new(File.join(__dir__,"Ber.d01.TS"), Time.parse("2020-06-29 12:00 UTC"))
  converter = WrfLibrary::JsonConverter::WrfJsonConverter.new(handler.data_repository)

  describe ".convert" do
    context "given a meteogram output file" do
      it "read it and create the correct json output" do
        converter.convert(__dir__)
        expect(FileUtils.compare_file(File.join(__dir__,"output.json"), File.join(__dir__,"expected_output.json"))).to be_truthy

        # clean up data from the test and catch errors since they should not let the test fail
        File.delete(File.join(__dir__,"output.json"))
      end
    end
  end

  describe ".convert" do
    context "given a meteogram output file" do
      it "read it and create the correct json output" do
        expect(converter.convert().empty?).to be_falsey 
      end
    end
  end

end
