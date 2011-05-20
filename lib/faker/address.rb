module Faker
  class Address < Base
    class << self
      def city
        [
          '%s %s%s' % [city_prefix, Name.first_name, city_suffix],
          '%s %s' % [city_prefix, Name.first_name],
          '%s%s' % [Name.first_name, city_suffix],
          '%s%s' % [Name.last_name, city_suffix],
        ].rand
      end

      def street_name
        [
          Proc.new { [Name.last_name, street_suffix].join(' ') },
          Proc.new { [Name.first_name, street_suffix].join(' ') }
        ].rand.call
      end

      def street_address(include_secondary = false)
        numerify("#{fetch('address.street_address')} #{street_name}#{' ' + secondary_address if include_secondary}")
      end

      def secondary_address
        numerify(fetch('address.secondary_address'))
      end

      def zip_code
        bothify(fetch('address.postcode')).upcase
      end
      alias_method :zip, :zip_code
      alias_method :postcode, :zip_code
      
      def street_suffix; fetch('address.street_suffix'); end
      def city_suffix;   fetch('address.city_suffix');   end
      def city_prefix;   fetch('address.city_prefix');   end
      def state_abbr;    fetch('address.state_abbr');    end
      def state;         fetch('address.state');         end
      def country;       fetch('address.country');       end
      
      # Returns a uk city or the uk city associated with a uk county
      # based on city with the same index as the county
      def uk_city(county = nil)
        if county.blank?
          fetch('address.uk_city')
        else
          index = I18n.translate(:faker)[:address][:uk_county].index(county)
          city = I18n.translate(:faker)[:address][:uk_city][index] if index
          city ? city : fetch('address.uk_city')
        end  
      end
      
      # Returns a uk county or the uk county associated with a uk city
      # based on city with the same index as the county
      def uk_county(city = nil)
        if city.blank?
          fetch('address.uk_county')
        else
          index = I18n.translate(:faker)[:address][:uk_city].index(city)
          county = I18n.translate(:faker)[:address][:uk_county][index] if index
          county ? county : fetch('address.uk_county')
        end  
      end

      # You can add whatever you want to the locale file, and it will get 
      # caught here... e.g., create a country_code array in your locale, 
      # then you can call #country_code and it will act like #country
      def method_missing(m, *args, &block)
        # Use the alternate form of translate to get a nil rather than a "missing translation" string
        if translation = I18n.translate(:faker)[:address][m]
          translation.respond_to?(:rand) ? translation.rand : translation
        else
          super
        end
      end
      
      # Deprecated
      alias_method :earth_country, :country
      alias_method :us_state, :state
      alias_method :us_state_abbr, :state_abbr
      alias_method :uk_postcode, :zip_code
      alias_method :uk_town, :city

    end
  end
end