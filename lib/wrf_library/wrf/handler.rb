# @Author: Benjamin Held
# @Date:   2017-11-03 18:52:27
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-11-15 20:10:22

require "ruby_utils/file_reader"
require "ruby_utils/data_repository"
require "wrf_library/meta_data"

module WrfLibrary

  module Wrf

    # Handler class that holds the data repository and the meta data for a wrf model result
    # The data can be added completely be leaving the optional values of the constructor
    # unchanged. But it also can be read only a subset of the provided data by setting
    # a duration and an offset
    class Handler

      # @return [DataRepository] the data repository for the data
      attr_reader :data_repository
      # @return [Float] the amount of time the forecast data comprises
      attr_reader :duration

      # initialization for data from a file
      # @param [String] filename the given filename
      # @param [Time] start_date the starting date and time of the model results
      # @param [Float] duration the optional forecast duration
      # @param [Float] offset the optional offset when to start with the data
      def initialize(filename, start_date, duration=Float::MAX, offset=0.0)
        data = RubyUtils::FileReader.new(filename, " ").data
        # create meta data from first entry
        meta_data = MetaData.new(data[0], start_date)
        data.delete_at(0)
        @data_repository = RubyUtils::DataRepository.new(meta_data)
        fill_repository(data, duration, offset, start_date)
      end

      # method to retrieve the complete data series for a given attribute
      # @param [Symbol] symbol the attribute that is requested
      # @return [Array] the data of the requested attribute
      # @raise [ArgumentError] if an invalid attribute is provided
      def retrieve_data_set(symbol)
        values = Array.new()
        begin
          @data_repository.repository.each { |data|
            value = data.send(symbol)
            values << value
          }
        rescue NoMethodError
          raise ArgumentError, "Error: Given symbol #{symbol} does not exist.".red
        end
        return values
      end

      private

      # method to fill the data into the data repository
      # @param [Array] data the unformatted input data
      # @param [Float] duration the forecast duration
      # @param [Float] offset the offset when to start with the data addition
      # @param [Time] start_date the starting date and time of the model results
      def fill_repository(data, duration, offset, start_date)
        data.each { |line|
          forecast_hours = line[1].to_f
          next if (forecast_hours < offset)
          entry = create_wrf_entry(line, start_date)
          if (forecast_hours - offset <= duration)
            @data_repository.add_data_entry(entry)
          else
            break
          end
        }
        @duration = @data_repository.repository.last.forecast_time
        nil
      end

      # method to create a new entry that can be put in the repository
      # @param [Array] elements the elements of a single line for an entry
      # @param [Time] start_date the starting date and time of the model results      
      # @return [WrfEntry] the created entry
      def create_wrf_entry(elements, start_date)
        entry = Entry.new()
        entry.forecast_time = start_date + elements[1].to_f * 3600
        entry.air_temperature = elements[5].to_f
        entry.mixing_ratio = elements[6].to_f
        entry.u_wind = elements[7].to_f
        entry.v_wind = elements[8].to_f
        entry.pressure = elements[9].to_f
        entry.longwave = elements[10].to_f
        entry.shortwave = elements[11].to_f
        entry.sensible_heat = elements[12].to_f
        entry.latent_heat = elements[13].to_f
        entry.skin_temperature = elements[14].to_f
        entry.soil_temperature = elements[15].to_f
        entry.cumulus_rainfall = elements[16].to_f
        entry.explicit_rainfall = elements[17].to_f
        entry.water_vapor = elements[18].to_f
        return entry
      end      

    end

  end

end
