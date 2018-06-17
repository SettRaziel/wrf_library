# @Author: Benjamin Held
# @Date:   2015-05-31 14:28:43
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2018-01-28 21:15:59

require_relative 'meta_data/meta_data'

# This class serves as a data repository storing the read data and handling the
# meta information
class DataRepository
  # @return [MetaData] the meta data of the dataset
  attr_reader :meta_data
  # @return [Array] an array containing all datasets
  attr_reader :repository

  # initialization
  # @param [MetaData] meta_data the meta data for the data set
  def initialize(meta_data)
    @meta_data = meta_data
    @repository = Array.new()
  end

  # reads the file and creates meta information and data of its content
  # @param [DataEntry] entry the data entry that should be added
  def add_data_entry(entry)
    @repository << entry
    return nil
  end

  private

end
