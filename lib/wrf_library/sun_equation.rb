#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-12-27 14:34:22
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-08 22:38:08

require "date"

module WrfLibrary

  module SunEquation

    # @return [Float] the rotation distance per hour
    @@rotation_time = 360.0 / 24.0
    # @return [Float] the zenith distance at rise and set
    @@cos_z = -0.01454

    # helper method to convert a radiant value into degrees
    # @param [Float] the angel in radians
    # @return [Float] the angle in degree
    def self.convert_radiant_to_degree(angle)
      angle * 180 / Math::PI
    end

    # helper method to convert a degree value into radians
    # @param [Float] the angle in degrees
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
    # @param [DateTime] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested    
    # @return [Float] the current day of the day
    def self.calculate_current_day_of_year(date=DateTime.now, longitude, event)
      offset = if (event == :rise) then 6.0 else 18.0 end
      date.yday().to_f + (offset - longitude / @@rotation_time) / 24
    end

    # method to calculate the solar mean
    # @param [DateTime] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested        
    # @return [Float] the solar mean anomaly
    def self.calculate_solar_mean_anomaly(date=DateTime.now, longitude, event)
      0.98560028 * calculate_current_day_of_year(date, longitude, event) - 3.289
    end

    # method to calculate the center equation
    # @param [DateTime] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested    
    # @return [Float] the center equation
    def self.calculate_center_equation(date=DateTime.now, longitude, event)
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
    # @param [Float] the result of the center equation
    # @return [Float] the sun declination value
    def self.calculate_sun_declination(center_equation)
      Math.asin(0.39782 * Math.sin(convert_degree_to_radiant(center_equation)))
    end

    # method to calculate the local hour angle
    # @param [DateTime] date the provided date or the current date if none is given
    # @param [Float] longitude the longitude of the requested location
    # @param [Float] latitude the latitude of the requested location
    # @param [Symbol] event the information if sunrise or sunset is requested
    # @return [Float] the local hour angle
    def self.calculate_local_hour_angle(date=DateTime.now, longitude, latitude, event)
      center_equation = calculate_center_equation(date, longitude, event)
      ascension = calculate_sun_ascension(center_equation)
      declination = calculate_sun_declination(center_equation)
      cos_h = (@@cos_z - Math.sin(declination) * Math.sin(convert_degree_to_radiant(latitude))) /
              (Math.cos(declination) * Math.cos(convert_degree_to_radiant(latitude)))
      360.0 - convert_radiant_to_degree(Math.acos(cos_h))
    end
  end

end
