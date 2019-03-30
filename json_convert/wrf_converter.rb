# @Author: Benjamin Held
# @Date:   2018-07-27 18:54:17
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-03-30 14:17:58

module JsonConverter

  require_relative '../data/wrf/wrf'

  class WrfJsonConverter < BaseJsonConverter

    private

    def add_additions()
        additions = Hash.new()
        additions[:grid_point] = generate_grid_data(@repository.meta_data.grid_data)
        additions[:grid_coordinates] = 
          generate_grid_coordinates(@repository.meta_data.grid_data)
        return additions
    end

    def generate_grid_data(grid_point)
      grid_data = Hash.new()
      grid_data[:grid_point] = { :x => grid_point.grid_point.x, 
                                 :y => grid_point.grid_point.y }
      return grid_data
    end

    def generate_grid_coordinates(grid_point)
      grid_coordinates = Hash.new()
      grid_coordinates[:grid_coordinates] = { :x => grid_point.grid_coordinates.x, 
                                              :y => grid_point.grid_coordinates.y }
      return grid_coordinates
    end

    def generate_data_values()
      data = Array.new()
      @repository.repository.each { |dataset|
        data << create_data_hash(dataset)
      }
      return data
    end

    def create_data_hash(dataset)
      data_entries = Hash.new()
      dataset.instance_variables.map{|ivar| 
        data_entries[ivar] = dataset.instance_variable_get(ivar)
      }
      return data_entries
    end

  end

end
