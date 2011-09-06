module Faker
  class Address < Base
    flexible :address

    class << self
      def city
        [
          '%s %s%s' % [city_prefix, Name.first_name, city_suffix],
          '%s %s' % [city_prefix, Name.first_name],
          '%s%s' % [Name.first_name, city_suffix],
          '%s%s' % [Name.last_name, city_suffix],
        ].sample
      end

      def street_name
        if Faker::Config.locale == :de
          fetch('address.street_name')
        else
          [
            Proc.new { [Name.last_name, street_suffix].join(' ') },
            Proc.new { [Name.first_name, street_suffix].join(' ') }
          ].sample.call
        end
      end

      def street_address(include_secondary = false)
        if Faker::Config.locale == :de
          numerify("#{street_name} #{building_number}#{' ' + secondary_address if include_secondary}")
        else
          numerify("#{building_number} #{street_name}#{' ' + secondary_address if include_secondary}")
        end
      end

      def secondary_address
        numerify(fetch('address.secondary_address'))
      end

      def zip_code
        bothify(fetch('address.postcode'))
      end
      alias_method :zip, :zip_code
      alias_method :postcode, :zip_code
      
      def street_suffix; fetch('address.street_suffix'); end
      def city_suffix;   fetch('address.city_suffix');   end
      def city_prefix;   fetch('address.city_prefix');   end
      def state_abbr;    fetch('address.state_abbr');    end
      def state;         fetch('address.state');         end
      def country;       fetch('address.country');       end

      def latitude
        ((rand * 180) - 90).to_s
      end

      def longitude
        ((rand * 360) - 180).to_s
      end

      # Deprecated
      alias_method :earth_country, :country
      alias_method :us_state, :state
      alias_method :us_state_abbr, :state_abbr
      alias_method :uk_postcode, :zip_code
      def uk_county; county; end

    end
  end
end
