require "date"

module WrfLibrary

  # module to calculate the time of the sunrise and sunset for a given location with
  # geo coordinates and the given day as a date
  # source: https://babel.hathitrust.org/cgi/pt?id=uc1.31822006852784&view=1up&seq=26
  module SunEquation

    # @return [Float] the rotation distance per hour
    @@rotation_time = 360.0 / 24.0
    # @return [Float] the zenith distance at rise and set
    @@cos_z = -0.01454

    # helper method to convert a radiant value into degrees
    # @param [Float] angle the angel in radians
    # @return [Float] the angle in degree
    def self.convert_radiant_to_degree(angle)
      angle * 180 / Math::PI
    end

    # helper method to convert a degree value into radians
    # @param [Float] angle the angle in degrees
    # @return [Float] the angle in radians
    def self.convert_degree_to_radiant(angle)
      angle * Math::PI / 180
    end

    # helper method to transform the given angle into the interval [-360:360]
    # @param [Float] angle the given angle
    # @return [Float] the normalized angle
    def self.normalize_angle(angle)
      angle -= 360.0 while (angle > 360.0)
      angle += 360.0 while (angle < -360.0)
      angle
    end

    # method to get the day of the year for the given date
    # @param [Time] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested    
    # @return [Float] the current day of the day
    def self.calculate_current_day_of_year(date=Time.now, longitude, event)
      offset = if (event == :rise) then 6.0 else 18.0 end
      date.yday().to_f + (offset - longitude / @@rotation_time) / 24
    end

    # method to calculate the solar mean
    # @param [Time] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested        
    # @return [Float] the solar mean anomaly
    def self.calculate_solar_mean_anomaly(date=Time.now, longitude, event)
      0.98560028 * calculate_current_day_of_year(date, longitude, event) - 3.289
    end

    # method to calculate the center equation
    # @param [Time] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested    
    # @return [Float] the center equation
    def self.calculate_center_equation(date=Time.now, longitude, event)
      m = calculate_solar_mean_anomaly(date, longitude, event)
      rad_m = convert_degree_to_radiant(m)
      l = m + 1.9148 * Math.sin(rad_m) + 0.02 * Math.sin(2*rad_m) + 282.634
      normalize_angle(l)
    end

    # method to calculate the sun ascension value
    # @param [Float] center_equation the result vaule of the center equation
    # @return [Float] the sun ascension value
    def self.calculate_sun_ascension(center_equation)
      ra = Math.atan(0.91746 * Math.tan(convert_degree_to_radiant(center_equation)))
      ran = normalize_angle(convert_radiant_to_degree(ra))
      sun_quadrant = (center_equation / 90.0).floor * 90
      ascension_quadrant = (ran / 90.0).floor * 90
      ran + (sun_quadrant - ascension_quadrant)
    end

    # method to calculate the sun declination value
    # @param [Float] center_equation the result of the center equation
    # @return [Float] the sun declination value
    def self.calculate_sun_declination(center_equation)
      Math.asin(0.39782 * Math.sin(convert_degree_to_radiant(center_equation)))
    end

    # method to calculate the local hour angle
    # @param [Time] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Float] latitude the latitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested
    # @return [Float] the local hour angle
    def self.calculate_local_hour_angle(date=Time.now, longitude, latitude, event)
      center_equation = calculate_center_equation(date, longitude, event)
      declination = calculate_sun_declination(center_equation)
      cos_h = (@@cos_z - Math.sin(declination) * Math.sin(convert_degree_to_radiant(latitude))) /
              (Math.cos(declination) * Math.cos(convert_degree_to_radiant(latitude)))
      return 360.0 - convert_radiant_to_degree(Math.acos(cos_h)) if (event == :rise)
      convert_radiant_to_degree(Math.acos(cos_h))
    end

    # method to calculate the local time of the given event
    # @param [Time] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Float] latitude the latitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested
    # @return [Float] the hour and minutes as a decimal float of the event
    def self.calculate_local_event_time(date=Time.now, longitude, latitude, event)
      h = calculate_local_hour_angle(date, longitude, latitude, event) / 15
      ascension = calculate_sun_ascension(calculate_center_equation(date, longitude, event))
      t = calculate_current_day_of_year(date, longitude, event)
      h + ascension / @@rotation_time - 0.06571* t - 6.622
    end

    # method to calculate the time of the given event
    # @param [Time] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Float] latitude the latitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested
    # @return [Float] the hour and minutes as a decimal float of the event
    def self.calculate_event_time(date=Time.now, longitude, latitude, event)
      t_l = calculate_local_event_time(date, longitude, latitude, event)
      t_l - longitude / @@rotation_time
    end

    # method to calculate the time of the sunrise for the given data
    # @param [Time] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Float] latitude the latitude of the requested location
    # @return [Float] the local timezone hour and minutes as a decimal float of the event
    def self.calculate_sunrise_time(date=Time.now, longitude, latitude)
      event_utc = calculate_event_time(date, longitude, latitude, :rise)
      event_utc += 24.0 if (event_utc < 0)
      event_utc -= 24.0 if (event_utc > 24.0)
      event_utc + date.gmt_offset / 3600
    end

    # method to calculate the time of the sunset for the given data
    # @param [Time] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Float] latitude the latitude of the requested location
    # @return [Float] the local timezone hour and minutes as a decimal float of the event
    def self.calculate_sunset_time(date=Time.now, longitude, latitude)
      event_utc = calculate_event_time(date, longitude, latitude, :sunset)
      event_utc += 24.0 if (event_utc < 0)
      event_utc -= 24.0 if (event_utc > 24.0)
      event_utc + date.gmt_offset / 3600
    end

  end

end
