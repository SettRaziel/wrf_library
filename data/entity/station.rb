# @Author: Benjamin Held
# @Date:   2017-11-05 20:15:57
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-03-07 17:55:24

module Entity

  # Simple data class to represent a station entity
  class Station

    # @return [String] the name of the station
    attr_reader :name
    # @return [String] the description of the station
    attr_reader :descriptor
    # @return [Number] the elevation of the station
    attr_reader :elevation
    # @return [Coordinate] the geo coordinates of the station
    attr_reader :coordinate

    # initialization
    # @param [String] the name of the station
    # @param [String] the description of the station
    # @param [Number] the elevation of the station
    # @param [Coordinate] the geo coordinates of the station
    def initialize(name, descriptor, elevation, geo_coordinate)
      @name = name
      @descriptor = descriptor
      @elevation = elevation
      @coordinate = geo_coordinate
    end

  end

end
