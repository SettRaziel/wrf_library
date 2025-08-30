module WrfLibrary

  module ApparentTemperature

    def self.calculate_apparent_temperature(temperature, wind_speed, humidity, pressure)
      temperature + 0.33 * calculate_water_vapour_pressure(temperature, pressure, humidity) - 0.7 * wind_speed - 4.0
    end

    # calculate the water vapour pressure
    # @param [Float] temperature the air temperature
    # @return [Float] the water vapour pressure
    def self.calculate_saturation_pressure(temperature)
      6.1094 * Math.exp((17.685 * temperature) / (temperature + 243.04))
    end

    def self.calculate_relative_humidity(temperature, pressure, humidity)
      saturation_pressure = calculate_saturation_pressure(temperature)
      partial_pressure = 0.622 * saturation_pressure / pressure
      rel_hum_pre = humidity * 100 / partial_pressure
      [ rel_hum_pre, 100.0 ].min
    end

    def self.calculate_water_vapour_pressure(temperature, pressure, humidity)
      relative_humidity = calculate_relative_humidity(temperature, pressure, humidity)
      6.105 * (relative_humidity / 100) * Math.exp((17.27 * temperature) / (temperature + 237.7))
    end

  end

end
