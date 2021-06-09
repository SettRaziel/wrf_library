require "wrf_library/wrf"

module WrfLibrary

  module JsonConverter

    # Abstract child class to add the relevant additional informations to the the JSON putput
    class WrfStationJsonConverter < BaseStationJsonConverter

      private

      # implementation of the abstract parent method. In addition to the data stored by
      # the parent class, the wrf data also stores data of the considered grid point
      # @return [Hash] the key-value hash for the json output
      def add_additions
          additions = Hash.new()
          additions[:grid_point] = generate_grid_data(@data.meta_data.grid_data)
          additions[:grid_coordinates] = 
            generate_grid_coordinates(@data.meta_data.grid_data)
          return additions
      end

      # method to generate a json Hash for the representation of a grid point
      # @param [GridPoint] grid_point the given grid point
      # @return [Hash] the key-value hash for the json output    
      def generate_grid_data(grid_point)
        grid_data = Hash.new()
        grid_data[:grid_point] = { :x => grid_point.grid_point.x, 
                                   :y => grid_point.grid_point.y }
        return grid_data
      end

      # method to generate a json Hash for the representation of a grid coordinate
      # @param [GridPoint] grid_point the given grid coordinate
      # @return [Hash] the key-value hash for the json output 
      def generate_grid_coordinates(grid_point)
        grid_coordinates = Hash.new()
        grid_coordinates[:grid_coordinates] = { :x => grid_point.grid_coordinates.x, 
                                                :y => grid_point.grid_coordinates.y }
        return grid_coordinates
      end

    end

  end

end
