#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-05-10 16:24:21
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-09 10:40:17

require 'spec_helper'
require 'wrf_library/json_converter'

describe WrfLibrary::JsonConverter::BaseStationJsonConverter do

  describe ".add_additions" do
    context "given a meteogram output file" do
      it "initialize converter and fail when calling abstract method" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2020, 06, 29))
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
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2020, 06, 29))
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
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2020, 06, 29))
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
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2020, 06, 29))
        converter = WrfLibrary::JsonConverter::BaseStationJsonConverter.new(handler.data_repository)
        expect { 
          converter.convert()
        }.to raise_error(NotImplementedError)
      end
    end
  end

end
