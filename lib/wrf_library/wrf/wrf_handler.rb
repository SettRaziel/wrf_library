# @Author: Benjamin Held
# @Date:   2017-11-03 18:52:27
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-04-01 16:08:33

module WrfLibrary

  module Wrf

    # Handler class that holds the data repository and the meta data for a wrf model result
    class WrfHandler

      require 'ruby_utils/file_reader'
      require 'ruby_utils/data_repository'
      require 'wrf_library/wrf_meta_data'

      # @return [DataRepository] the data repository for the data
      attr_reader :data_repository

      # initialization
      # @param [String] filename the given filename
      # @param [Time] start_date the starting date and time of the model results
      # @param [float] duration the optional forecast duration
      def initialize(filename, start_date, duration=Float::MAX)
        data = RubyUtils::FileReader.new(filename, ' ').data
        # create meta data from first entry
        meta_data = WrfMetaData.new(data[0], start_date)
        data.delete_at(0)
        @data_repository = RubyUtils::DataRepository.new(meta_data)
        fill_repository(data, duration)
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
        rescue NoMethodError => e
          raise ArgumentError, "Error: Given symbol #{symbol} does not exist.".red
        end
        return values
      end

      private

      # method to fill the data into the data repository
      # @param [Array] data the unformatted input data
      # @param [float] duration the forecast duration
      def fill_repository(data, duration)
        data.each { |line|
          entry = create_wrf_entry(line)
          if (entry.forecast_time <= duration)
            @data_repository.add_data_entry(entry)
          else
            break
          end
        }
        nil
      end

      # method to create a new entry that can be put in the repository
      # @params [Array] elements the elements of a single line for an entry
      # @return [WrfEntry] the created entry
      def create_wrf_entry(elements)
        entry = WrfEntry.new()
        entry.forecast_time = elements[1].to_f
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
