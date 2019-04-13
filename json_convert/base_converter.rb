# @Author: Benjamin Held
# @Date:   2018-06-23 17:03:05
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-04-13 15:54:16

# Module to hold the classes handling the conversion of weather data into a
# predefined json format.
module JsonConverter

  require 'json'
  require_relative '../ruby_utils/data/data_repository'
  require_relative '../ruby_utils/string/string'

  # Abstract parent class for the json converter to convert preread weather data
  # into the specified output format. The metadata is identical for all
  # child classes, the weather values can depend on the different attributes.
  class BaseJsonConverter

    # initialization
    # @param [DataRepository] the prefilled repository
    def initialize(repository)
      @repository = repository
    end

    # method to convert the data of repository into the given json output
    def convert
      output = Hash.new()

      output[:meta_data] = generate_meta_hash()
      output[:weather_data] = generate_data_values()
      file = File.open("output.json", "w")
      file.write(JSON.pretty_generate(output))
      nil
    end

    private

    # @return [DataRepository] the data repository
    attr_reader :repository

    # methode to create the meta entry based on the meta data in the repoitory
    # @return [Hash] the prepared key/value hash of the meta data for the
    # json conversion
    def generate_meta_hash()
      meta_data = @repository.meta_data
      meta_hash = Hash.new()
      meta_hash[:station] = generate_station_hash(meta_data.station)
      meta_hash[:start_date] = meta_data.start_date
      meta_hash = meta_hash.merge(add_additions())
      return meta_hash
    end

    # method to create the station entry based on the meta data in the repository
    # @param [Station] the station data
    # @return [Hash] the prepared key/value hash of the station for the
    # json conversion
    def generate_station_hash(station)
      station_hash = Hash.new()
      station_hash[:name] = station.name
      station_hash[:descriptor] = station.descriptor
      station_hash[:elevation] = station.elevation
      station_hash[:coordinate] = { :x => station.coordinate.x, 
                                    :y => station.coordinate.y }
      return station_hash
    end

    # abstract method which allows additions to the meta data hash if present
    # @raise [NotImplementedError] if the child class does not implement this
    # method
    def add_additions()
      fail NotImplementedError, " Error: the subclass #{self.class} needs " \
           "to implement the method: add_additions from its base class".red
    end

    # abstract method which adds the weather data to the weather key that will
    # be converted into json via a Hash. If this method implements faulty
    # Hashes the json conversion will fail.
    # @raise [NotImplementedError] if the child class does not implement this
    # method
    def generate_data_values()
      fail NotImplementedError, " Error: the subclass #{self.class} needs " \
           "to implement the method: generate_data_values from its base class".red
    end

  end

end
