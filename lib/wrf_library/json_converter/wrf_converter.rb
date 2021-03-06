# @Author: Benjamin Held
# @Date:   2018-07-27 18:54:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-09-20 16:58:43

require "wrf_library/wrf"

module WrfLibrary

  module JsonConverter

    # Child class to generate valid json output for the result data of a given wrf meteogram
    # result already stored in a data repository
    class WrfJsonConverter < BaseStationJsonConverter

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

      # implementation of the abstract parent method to create valid json objects
      # for the stored data values
      # @return [Hash] the key-value hashes for the json output 
      def generate_data_values
        data_array = Array.new()
        @data.repository.each { |dataset|
          data_array << create_data_hash(dataset)
        }
        return data_array
      end

      # method to create a valid json hash for a given data entry
      # @param [WrfEntry] dataset the given data entry
      # @return [Hash] the key-value hashes for the json output     
      def create_data_hash(dataset)
        data_entries = Hash.new()
        dataset.instance_variables.map{ |ivar| 
          data_entries[ivar] = dataset.instance_variable_get(ivar)
        }
        return data_entries
      end

    end

  end

end
