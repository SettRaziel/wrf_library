module WrfLibrary

  # module to calculate the apparent temperature, more specific the australian apparent temperature
  # as described in https://en.wikipedia.org/wiki/Apparent_temperature. The apparent temperature 
  # takes the water vapor pressure, the wind speed in 10 m and the air temperature to calculate the temperature.
  # For lower temperatures the apparent temperatures the results are related to the wind chill while higher 
  # temperature are related to heat indices
  module ApparentTemperature

    # calculates the apparent temperature
    # @param [Float] temperature the air temperature in degree celcius
    # @param [Float] wind_speed the wind speed in kilometer per hour
    # @param [Float] humidity the vapor mixing ratio in kg/kg
    # @param [Float] pressure the air pressure in hectopascal
    # @return [Float] the apparent temperature
    def self.calculate_apparent_temperature(temperature, wind_speed, humidity, pressure)
      temperature + 0.33 * calculate_water_vapour_pressure(temperature, pressure, humidity) - 0.7 * wind_speed - 4.0
    end

    # calculates the water vapour pressure
    # @param [Float] temperature the air temperature
    # @return [Float] the water vapour pressure
    def self.calculate_saturation_pressure(temperature)
      6.1094 * Math.exp((17.685 * temperature) / (temperature + 243.04))
    end

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

    # calculates the water vapor pressure for the current condition
    # @param [Float] temperature the air temperature in degree celcius
    # @param [Float] humidity the vapor mixing ratio in kg/kg
    # @param [Float] pressure the air pressure in hectopascal
    # @return [Float] the water vapor pressure
    def self.calculate_water_vapour_pressure(temperature, pressure, humidity)
      relative_humidity = calculate_relative_humidity(temperature, pressure, humidity)
      6.105 * (relative_humidity / 100) * Math.exp((17.27 * temperature) / (temperature + 237.7))
    end

  end

end
