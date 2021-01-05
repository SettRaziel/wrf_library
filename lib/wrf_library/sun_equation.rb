#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-12-27 14:34:22
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-05 19:02:09

require "date"

module WrfLibrary

  module SunEquation

    # method to get the day of the year for the given date
    # @param [DateTime] date the provided date or the current date if none is given
    # @return [Float] the current day of the day
    def self.calculate_current_day_of_year(date=DateTime.now)
      date.yday().to_f + date.hour / 24.0 + date.minute / 60 + date.offset
    end

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

    # method to calculate the solar mean
    # @param [DateTime] date the provided date or the current date if none is given
    # @return [Float] the solar mean anomaly
    def self.calculate_solar_mean_anomaly(date=DateTime.now)
      0.98560028 * calculate_current_day_of_year(date) - 3.289
    end

    # method to calculate the center equation
    # @param [DateTime] date the provided date or the current date if none is given
    # @return [Float] the center equation
    def self.calculate_center_equation(date=DateTime.now)
      m = calculate_solar_mean_anomaly(date)
      rad_m = convert_degree_to_radiant(m)
      l = m + 1.9148 * Math.sin(rad_m) + 0.02 * Math.sin(2*rad_m) + 282.634
      l -= 360.0 while (l > 360.0)
      l += 360.0 while (l < -360.0)
      return l
    end

  end

end
