# @Author: Benjamin Held
# @Date:   2019-07-04 20:08:07
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-25 21:29:06

require 'test/unit'
require 'wrf_library/wrf'

class TestWRFHandler < Test::Unit::TestCase

  def test_repository_notnil
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    data = handler.data_repository.repository
    assert_not_nil(data, "Repository data should not be nil.")
  end

  def test_repository_datacount
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    data = handler.data_repository.repository
    assert_true(data.size == 5, "Repository data should should contain 5 entries.")
  end

  def test_temperature_values
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    temperature_values = handler.retrieve_data_set(:air_temperature)
    assert_true(temperature_values[0].round(3) == 294.716, "First temperature value is wrong.")
    assert_true(temperature_values[4].round(3) == 293.831, "Last temperature value is wrong.")
  end

end
