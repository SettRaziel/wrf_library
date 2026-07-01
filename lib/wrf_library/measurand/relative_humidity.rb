module WrfLibrary

  module Measurand

    # module to calculate the relative humidity for a given temperature, pressure and humidity.
    module RelativeHumidity

      # calculates the relative humidity
      # @param [Float] temperature the air temperature in degree celcius
      # @param [Float] humidity the vapor mixing ratio in kg/kg
      # @param [Float] pressure the air pressure in hectopascal
      # @return [Float] the relative humidity in %
      def self.calculate_relative_humidity(temperature, pressure, humidity)
        saturation_pressure = calculate_saturation_pressure(temperature)
        partial_pressure = 0.622 * saturation_pressure / pressure
        rel_hum_pre = humidity * 100 / partial_pressure
        [ rel_hum_pre, 100.0 ].min
      end

      # calculates the water vapour pressure
      # @param [Float] temperature the air temperature in degree celsius
      # @return [Float] the water vapour pressure
      def self.calculate_saturation_pressure(temperature)
        6.1094 * Math.exp((17.685 * temperature) / (temperature + 243.04))
      end

    end

  end

end
