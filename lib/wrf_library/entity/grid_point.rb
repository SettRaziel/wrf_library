# @Author: Benjamin Held
# @Date:   2017-11-11 11:22:30
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-25 21:17:42

module WrfLibrary

  module Entity

    # Simple data class that abstracts a grid point with grid indices
    # and the corresponding geographical data
    class GridPoint

      # @return [Coordinate] the tupel representing the grid point in the grid
      attr_reader :grid_point
      # @return [Coordinate] the tupel representing the geographical coordinates
      attr_reader :grid_coordinates

      # initialization
      # @param [Integer] p_x x-coordinate of the grid point
      # @param [Integer] p_y y-coordinate of the grid point
      # @param [Float] c_x x-coordinate of the geographical coordinate
      # @param [Float] c_y y-coordinate of the geographical coordinate
      def initialize(p_x, p_y, c_x, c_y)
        @grid_point = Coordinate.new(p_x, p_y)
        @grid_coordinates = Coordinate.new(c_x, c_y)
      end

    end

  end

end
