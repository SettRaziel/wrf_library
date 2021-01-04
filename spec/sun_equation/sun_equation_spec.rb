#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-12-27 14:45:56
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-04 19:38:40

require "spec_helper"
require "wrf_library/sun_equation"

describe WrfLibrary::SunEquation do

  describe "#calculate_current_julian_day" do
    context "given a date" do
      it "calculate the julian day for at in reference to jan 1th 2000" do
        expect(WrfLibrary::SunEquation.calculate_current_julian_day(DateTime.new(2000,1,1,12))).to eq(0.0008)
      end
    end
  end

  describe "#calculate_current_julian_day" do
    context "given a date" do
      it "calculate the julian day for at in reference to jan 1th 2000" do
        expect(WrfLibrary::SunEquation.calculate_current_julian_day(DateTime.new(2014,6,29,12))).to eq(5293.0008)
      end
    end
  end

  describe "#convert_radiant_to_degree" do
    context "given an angle in radians" do
      it "calculate the corresponding angle in degree" do
        expect(WrfLibrary::SunEquation.convert_radiant_to_degree(Math::PI)).to eq(180.0)
      end
    end
  end

  describe "#convert_radiant_to_degree" do
    context "given an angle in radians" do
      it "calculate the corresponding angle in degree" do
        expect(WrfLibrary::SunEquation.convert_radiant_to_degree(0.23212879051524585)).to eq(13.3)
      end
    end
  end

  describe "#convert_radiant_to_degre" do
    context "given an angle in radians" do
      it "calculate the corresponding angle in degree" do
        expect(WrfLibrary::SunEquation.convert_radiant_to_degree(0.39706240482870997)).to eq(22.75)
      end
    end
  end

  describe "#convert_degree_to_radiant" do
    context "given an angle in degree" do
      it "calculate the corresponding angle in radians" do
        expect(WrfLibrary::SunEquation.convert_degree_to_radiant(180)).to eq(Math::PI)
      end
    end
  end

  describe "#convert_degree_to_radiant" do
    context "given an angle in degree" do
      it "calculate the corresponding angle in radians" do
        expect(WrfLibrary::SunEquation.convert_degree_to_radiant(13.3)).to eq(0.23212879051524585)
      end
    end
  end

  describe "#convert_degree_to_radiant" do
    context "given an angle in degree" do
      it "calculate the corresponding angle in radians" do
        expect(WrfLibrary::SunEquation.convert_degree_to_radiant(22.75)).to eq(0.39706240482870997)
      end
    end
  end

end
