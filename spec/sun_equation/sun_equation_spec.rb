#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-12-27 14:45:56
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-06 19:49:30

require "spec_helper"
require "wrf_library/sun_equation"

describe WrfLibrary::SunEquation do

  describe "#calculate_current_day_of_year" do
    context "given a date" do
      it "calculate the date of the year for the given date" do
        expect(
          WrfLibrary::SunEquation.calculate_current_day_of_year(DateTime.new(2014,1,29,12,00,00,"+06:00"),13.3,:rise).round(3)
          ).to eq(29.213)
      end
    end
  end

  describe "#calculate_current_day_of_year" do
    context "given a date" do
      it "calculate the date of the year for the given date" do
        expect(
          WrfLibrary::SunEquation.calculate_current_day_of_year(DateTime.new(2014,6,29,12),13.3,:sunset).round(3)
          ).to eq(180.713)
      end
    end
  end

  describe "#calculate_current_day_of_year" do
    context "given a date" do
      it "calculate the date of the year for the given date" do
        expect(
          WrfLibrary::SunEquation.calculate_current_day_of_year(DateTime.new(2021,6,25),-74.3,:rise).round(3)
          ).to eq(176.456)
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

  describe "#calculate_solar_mean_anomaly" do
    context "given an angle in degree" do
      it "calculate the corresponding angle in radians" do
        expect(
          WrfLibrary::SunEquation.calculate_solar_mean_anomaly(DateTime.new(2014,6,25,12,00,00,"-04:00"),-74.3,:rise).round(3)
          ).to eq(170.626)
      end
    end
  end

  describe "#calculate_center_equation" do
    context "given an date" do
      it "calculate the corresponding center equation" do
        expect(
          WrfLibrary::SunEquation.calculate_center_equation(DateTime.new(2014,6,25,12,00,00,"-04:00"),-74.3,:rise).round(3)
          ).to eq(93.566)
      end
    end
  end

end
