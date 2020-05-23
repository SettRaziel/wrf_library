#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-05-23 21:03:43
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-05-23 21:12:00

require "spec_helper"
require "wrf_library/time_converter"

describe WrfLibrary::TimeConverter do

  describe "#get_offset_modelrun" do
    context "given a hour in string representation" do
      it "parse the integer and calculate the offset" do
        expect(WrfLibrary::TimeConverter.get_offset_modelrun("11")).to eq(13)
      end
    end
  end

  describe "#get_offset_modelrun" do
    context "given a hour in string representation" do
      it "parse the integer and calculate the offset" do
        expect(WrfLibrary::TimeConverter.get_offset_modelrun("00")).to eq(0)
      end
    end
  end

  describe "#get_offset_modelrun" do
    context "given a hour in string representation" do
      it "parse the integer and calculate the offset" do
        expect(WrfLibrary::TimeConverter.get_offset_modelrun("24")).to eq(0)
      end
    end
  end

  describe "#get_offset_modelrun" do
    context "given an invalid hour in string representation" do
      it "try to parse the integer and raise error" do
        expect { 
          WrfLibrary::TimeConverter.get_offset_modelrun("-1")
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe "#get_offset_modelrun" do
    context "given an invalid hour in string representation" do
      it "try to parse the integer and raise error" do
        expect { 
          WrfLibrary::TimeConverter.get_offset_modelrun("abc")
        }.to raise_error(TypeError)
      end
    end
  end

  describe "#get_offset_modelrun" do
    context "given an invalid hour in string representation" do
      it "try to parse the integer and raise error" do
        expect { 
          WrfLibrary::TimeConverter.get_offset_modelrun("25")
        }.to raise_error(ArgumentError)
      end
    end
  end

end
