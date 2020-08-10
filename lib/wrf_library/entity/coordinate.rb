# @Author: Benjamin Held
# @Date:   2017-11-05 20:22:28
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-08-10 18:20:47

module WrfLibrary

  # This module holds basic entity classes that represent entity information of 
  # a forecast location
  module Entity

    # Simple coordinate class, that can have any combination of numbers for the
    # considered tupel:
    # * (int, int) indicates a coordinate on a grid as (x,y)
    # * (float, float) indicates a geo coordinate as (lon, lat)
    class Coordinate

      # @return [Number] the first coordinate of the tupel, commonly the abscissa
      attr_reader :x
      # @return [Number] the second coordinate of the tupel, commonly the ordinate
      attr_reader :y

      # initialization
      # @param [Number] x the first coordinate of the tupel
      # @param [Number] y the second coordinate of the tupel
      def initialize(x, y)
        @x = x
        @y = y
      end

    end  

  end

end
