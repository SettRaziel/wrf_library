# @Author: Benjamin Held
# @Date:   2019-06-29 13:58:56
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-02-25 21:28:58

require 'test/unit'
require 'wrf_library/wrf'

class TestWRFMetaData < Test::Unit::TestCase

  def test_metadata_notnil
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    meta_data = handler.data_repository.meta_data
    assert_not_nil(meta_data, "MetaData should not be nil.")
  end

  def test_gridpoints_correct
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    geo_point = handler.data_repository.meta_data.grid_data.grid_point
    assert_equal(geo_point.x, 222, "GridPoint.x incorrect")
    assert_equal(geo_point.y, 185, "GridPoint.y incorrect")
  end

  def test_gridcoordinate_correct
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    grid_coordinate = handler.data_repository.meta_data.grid_data.grid_coordinates
    assert_equal(grid_coordinate.x, 52.469, "GeoCoordinate.x incorrect")
    assert_equal(grid_coordinate.y, 13.371, "GeoCoordinate.y incorrect")
  end

  def test_stationname_correct
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    station = handler.data_repository.meta_data.station
    assert_equal(station.name, "Berlin", "Station name incorrect")
  end

  def test_stationdescription_correct
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    station = handler.data_repository.meta_data.station
    assert_equal(station.descriptor, "Ber", "Station description incorrect")
  end

  def test_stationelevation_correct
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    station = handler.data_repository.meta_data.station
    assert_equal(station.elevation, 44.2, "Station elevation incorrect")
  end

  def test_stationcoordinate_correct
    handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
    station_coordinate = handler.data_repository.meta_data.station.coordinate
    assert_equal(station_coordinate.x, 52.490, "GeoCoordinate.x incorrect")
    assert_equal(station_coordinate.y, 13.360, "GeoCoordinate.y incorrect")
  end  

end
