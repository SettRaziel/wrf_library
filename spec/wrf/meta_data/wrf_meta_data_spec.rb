#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-01 13:59:08
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-06 17:33:13

require 'spec_helper'

describe WrfLibrary::WrfMetaData do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have meta data in the handler" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        expect(handler.data_repository.meta_data).to be_truthy
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct grid point data" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        geo_point = handler.data_repository.meta_data.grid_data.grid_point
        expect(geo_point.x).to match(222)
        expect(geo_point.y).to match(185)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct grid coordinate data" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        grid_coordinate = handler.data_repository.meta_data.grid_data.grid_coordinates
        expect(grid_coordinate.x).to match(52.469)
        expect(grid_coordinate.y).to match(13.371)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station name" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        station = handler.data_repository.meta_data.station
        expect(station.name).to match('Berlin')
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station description" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        station = handler.data_repository.meta_data.station
        expect(station.descriptor).to match('Ber')
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station elevation" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        station = handler.data_repository.meta_data.station
        expect(station.elevation).to match(44.2)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have the correct station elevation" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        station_coordinate = handler.data_repository.meta_data.station.coordinate
        expect(station_coordinate.x).to match(52.490)
        expect(station_coordinate.y).to match(13.360)        
      end
    end
  end

end
