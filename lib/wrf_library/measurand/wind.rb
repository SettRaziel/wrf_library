module WrfLibrary

  module Measurand

    module Wind

      # method to calculate the wind speed from its two dimenstional components
      # @param [Array] u_component the horizontal wind component
      # @param [Array] v_component the vertical wind component
      # @return [Array] the two dimensional wind speed
      def self.calculate_windspeed(u_component, v_component)
        r2d = 180.0 / (Math.atan(1) * 4.0)
        wind_speed = Array.new()
        u_component.zip(v_component).each { |u, v| 
          wind_speed << Math.sqrt(u**2+v**2)
        }
        wind_speed
      end

    end

  end

end
