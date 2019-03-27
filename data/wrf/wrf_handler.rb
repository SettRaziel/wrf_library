# @Author: Benjamin Held
# @Date:   2017-11-03 18:52:27
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2019-03-27 19:45:20

module Wrf

  # Handler class that holds the data repository and the meta data for a wrf model result
  class WrfHandler

    require_relative '../file_reader'
    require_relative '../data_repository'

    # @return [DataRepository] the data repository for the data
    attr_reader :data_repository

    # initialization
    # @param [String] the given filename
    # @param [Date] the starting date of the model results
    def initialize(filename, start_date)
      data = FileReader.new(filename, ' ').data
      # create meta data from first entry
      meta_data = MetaData::WrfMetaData.new(data[0], start_date)
      data.delete_at(0)
      # create repository and add them
      @data_repository = DataRepository.new(meta_data)
      data.each { |line|
        @data_repository.add_data_entry(create_wrf_entry(line))
      }
      nil
    end

    private

    # Method to create a new entry that can be put in the repository
    # @params [Array] the elements of a single line for an entry
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
