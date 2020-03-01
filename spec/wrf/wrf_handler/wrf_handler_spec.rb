#!/usr/bin/ruby
# @Author: Benjamin Held
# @Date:   2020-03-01 11:07:37
# @Last Modified by:   Benjamin Held
# @Last Modified time: 2020-03-01 11:42:41

require 'spec_helper'
require 'wrf_library/wrf'

describe WrfLibrary::Wrf::WrfHandler do

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have data in the repository" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        expect(handler.data_repository.repository).to be_truthy
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and have 5 entries in the repository" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        expect(handler.data_repository.repository.size).to match(5)
      end
    end
  end

  describe ".new" do
    context "given a meteogram output file and the date" do
      it "read the file and check for correct temperature values" do
        handler = WrfLibrary::Wrf::WrfHandler.new(File.join(__dir__,"Ber.d01.TS"), Date.new(2019, 06, 29))
        temperature_values = handler.retrieve_data_set(:air_temperature)
        expect(temperature_values[0].round(3)).to match(294.716)
        expect(temperature_values[4].round(3)).to match(293.831)
      end
    end
  end

end
