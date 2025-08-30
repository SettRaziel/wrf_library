require "spec_helper"
require "wrf_library/apparent_temperature"

# values checked with https://www.vcalc.com/wiki/australian-apparent-temperature
describe WrfLibrary::ApparentTemperature do

  describe "#calculate_apparent_temperature" do
    context "given a temperature, wind speed, humidity and pressure" do
      it "calculate the apparent temperature" do
        expect(
          # relative humidity is 47.69 %
          WrfLibrary::ApparentTemperature.calculate_apparent_temperature(15.0, 10.0, 0.005, 1013.25).round(2)
          ).to eq(6.68)
      end
    end
  end

  describe "#calculate_apparent_temperature" do
    context "given a temperature, wind speed, humidity and pressure" do
      it "calculate the apparent temperature" do
        expect(
          # relative humidity is 51.23 %
          WrfLibrary::ApparentTemperature.calculate_apparent_temperature(25.0, 10.0, 0.01, 1013.25).round(2)
          ).to eq(19.34)
      end
    end
  end

  describe "#calculate_apparent_temperature" do
    context "given a temperature, wind speed, humidity and pressure" do
      it "calculate the apparent temperature" do
        expect(
          # relative humidity is 32.19 %
          WrfLibrary::ApparentTemperature.calculate_apparent_temperature(33.0, 10.0, 0.01, 1013.25).round(2)
          ).to eq(27.32)
      end
    end
  end

  describe "#calculate_apparent_temperature" do
    context "given a temperature, wind speed, humidity and pressure" do
      it "calculate the apparent temperature" do
        expect(
          # relative humidity is 32.19 %
          WrfLibrary::ApparentTemperature.calculate_apparent_temperature(33.0, 1.0, 0.01, 1013.25).round(2)
          ).to eq(33.62)
      end
    end
  end

end
