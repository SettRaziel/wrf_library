require "spec_helper"
require "wrf_library/statistic"

describe WrfLibrary::Measurand::Pressure do

  describe "#reduce_pressure_to_sealevel" do
    context "given the temperature, pressure and station elevation" do
      it "calculates the pressure reduced to sea level" do
        temperature = [ 270.15 ]
        pressure = [ 961.00 ]
        elevation = 500.0
        sealevel_pressure = WrfLibrary::Measurand::Pressure.reduce_pressure_to_sealevel(pressure, temperature, elevation)
        expect(sealevel_pressure[0].round(2)).to eq(1023.13)
      end
    end
  end

  describe "#reduce_pressure_to_sealevel" do
    context "given the temperature, pressure and station elevation" do
      it "calculates the pressure reduced to sea level" do
        temperature = [ 271.15 ]
        pressure = [ 947.00 ]
        elevation = 500.0
        sealevel_pressure = WrfLibrary::Measurand::Pressure.reduce_pressure_to_sealevel(pressure, temperature, elevation)
        expect(sealevel_pressure[0].round(2)).to eq(1008.00)
      end
    end
  end

end
