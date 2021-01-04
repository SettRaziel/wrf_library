#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-12-27 14:34:22
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2021-01-04 19:13:06

require "date"

module WrfLibrary

  module SunEquation

    # method to calculate the day since jan 1st 2000 in the julian calender
    # and with leap correction
    # @param [DateTime] date the provided date or the current date if none is given
    # @return [Float] the julian day of the given date since the reference day of jan 1st 2000
    def self.calculate_current_julian_day(date=DateTime.now)
      date.jd().to_f - 2451545.0 + 0.0008
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

  end

end
