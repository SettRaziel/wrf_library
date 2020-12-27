#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-12-27 14:34:22
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-12-27 22:07:31

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

  end

end
