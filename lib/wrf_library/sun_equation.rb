#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-12-27 14:34:22
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-06 19:58:18

require "date"

module WrfLibrary

  module SunEquation

    # @return [Float] the rotation distance per hour
    @@rotation_time = 360.0 / 24.0

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
    # @return [Float] the current day of the day
    def self.calculate_current_day_of_year(date=DateTime.now, longitude, event)
      offset = if (event == :rise) then 6.0 else 18.0 end
      date.yday().to_f + (offset - longitude / @@rotation_time) / 24
    end

    # method to calculate the solar mean
    # @param [DateTime] date the provided date or the current date if none is given
    # @return [Float] the solar mean anomaly
    def self.calculate_solar_mean_anomaly(date=DateTime.now, longitude, event)
      0.98560028 * calculate_current_day_of_year(date, longitude, event) - 3.289
    end

    # method to calculate the center equation
    # @param [DateTime] date the provided date or the current date if none is given
    # @return [Float] the center equation
    def self.calculate_center_equation(date=DateTime.now, longitude, event)
      m = calculate_solar_mean_anomaly(date, longitude, event)
      rad_m = convert_degree_to_radiant(m)
      l = m + 1.9148 * Math.sin(rad_m) + 0.02 * Math.sin(2*rad_m) + 282.634
      normalize_angle(l)
    end

  end

end
