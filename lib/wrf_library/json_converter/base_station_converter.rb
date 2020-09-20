#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-02 18:44:47
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-09-20 16:58:36

require "ruby_utils/data_repository"
require "ruby_utils/string"

module WrfLibrary

  # Module to hold the classes handling the conversion of weather data into a
  # predefined json format.
  module JsonConverter

    # Abstract parent class for the json converter to convert preread weather data
    # into the specified output format. The metadata is identical for all
    # child classes, the weather values can depend on the different attributes.
    class BaseStationJsonConverter

      # initialization
      # @param [DataRepository] repository the prefilled repository
      def initialize(repository)
        @data = repository
      end

      # method to convert the data of repository into the given json output
      # @param [String] filepath the filepath where the output should be created,
      # if nil the output will be printed to stdout
      # @return [String] the json formatted output
      def convert(filepath=nil)
        output = Hash.new()
        output[:meta_data] = generate_meta_hash()
        output[:weather_data] = generate_data_values()

        output_string = JSON.pretty_generate(output)
        if (filepath != nil)
          file = File.open(File.join(filepath,"output.json"), "w")
          file.write(output_string)
          file.close
        end
        return output_string
      end

      private

      # @return [DataRepository] the data repository
      attr_reader :data

      # methode to create the meta entry based on the meta data in the repoitory
      # @return [Hash] the prepared key/value hash of the meta data for the
      # json conversion
      def generate_meta_hash
        meta_data = @data.meta_data
        meta_hash = Hash.new()
        meta_hash[:station] = generate_station_hash(meta_data.station)
        meta_hash[:start_date] = meta_data.start_date
        meta_hash = meta_hash.merge(add_additions())
        return meta_hash
      end

      # method to create the station entry based on the meta data in the repository
      # @param [Station] station the station data
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
      def add_additions
        fail NotImplementedError, " Error: the subclass #{self.class} needs " \
             "to implement the method: add_additions from its base class".red
      end

      # abstract method which adds the weather data to the weather key that will
      # be converted into json via a Hash. If this method implements faulty
      # Hashes the json conversion will fail.
      # @raise [NotImplementedError] if the child class does not implement this
      # method
      def generate_data_values
        fail NotImplementedError, " Error: the subclass #{self.class} needs " \
             "to implement the method: generate_data_values from its base class".red
      end

    end

  end

end
