#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-12-27 14:45:56
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-12-27 22:10:01

require "spec_helper"
require "wrf_library/sun_equation"

describe WrfLibrary::SunEquation do

  describe "#calculate_current_julian_day" do
    context "given a date" do
      it "calculate the julian day for at in reference to jan 1th 2000" do
        expect(WrfLibrary::SunEquation.calculate_current_julian_day(DateTime.new(2000,1,1))).to eq(0.0008)
      end
    end
  end

  describe "#calculate_current_julian_day" do
    context "given a date" do
      it "calculate the julian day for at in reference to jan 1th 2000" do
        expect(WrfLibrary::SunEquation.calculate_current_julian_day(DateTime.new(2014,6,29))).to eq(5293.0008)
      end
    end
  end

end
