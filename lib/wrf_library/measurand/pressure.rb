module WrfLibrary

  # Module for methods and classes regarding meotrological measurands
  module Measurand

    # Helper module to calculate wind information from the wind vector components
    module Pressure

    # function to reduce the station pressure to sea level using the barometric formula
    # with the arithmetic mean of the temperature from the station and reduced to sea level
    def self.reduce_pressure_to_sealevel(pressure, temperature, station_elevation)
      r_0 = 287.05 # J/(kg*K)
      g = 9.80665 # m/s^2
      sealevel_pressure = Array.new()

      pressure.each_with_index { |entry, i|
        t_m = temperature[i] + station_elevation / 200 # approx. dT = 1 K / 100 m
        sealevel_pressure[i] = entry * Math.exp((g * station_elevation)/(r_0 * t_m))
      }

      sealevel_pressure
    end

    end

  end

end
