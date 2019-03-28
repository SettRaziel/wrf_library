# @Author: Benjamin Held
# @Date:   2018-06-23 17:03:05
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-03-28 19:35:14

module Converter

  require 'json'
  require_relative '../data/data_repository'
  require_relative '../string/string'

  class BaseConverter

    def initialize(repository)
      @repository = repository
    end

    def convert
      output = Hash.new()

      output[:meta_data] = generate_meta_hash()
      output[:weather_data] = generate_data_values()
      file = File.open("output.json", "w")
      file.write(JSON.generate(output))
    end

    private

    attr_reader :repository

    def generate_meta_hash()
      meta_data = @repository.meta_data
      meta_hash = Hash.new()
      meta_hash[:station] = generate_station_hash(meta_data.station)
      meta_hash[:start_date] = meta_data.start_date
      meta_hash = meta_hash.merge(add_additions())
      return meta_hash
    end

    def generate_station_hash(station)
      station_hash = Hash.new()
      station_hash[:name] = station.name
      station_hash[:descriptor] = station.descriptor
      station_hash[:elevation] = station.elevation
      station_hash[:coordinate] = { :x => station.coordinate.x, 
                                    :y => station.coordinate.y }
      return station_hash
    end

    def add_additions()
      fail NotImplementedError, " Error: the subclass #{self.class} needs " \
           "to implement the method: add_additions from its base class".red
    end

    def generate_data_values()
      fail NotImplementedError, " Error: the subclass #{self.class} needs " \
           "to implement the method: generate_data_hashes from its base class".red
    end

  end

end
