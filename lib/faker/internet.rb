module Faker
  class Internet < Base
    class << self
      def email(name = nil, domain = nil)
        [ user_name(name), domain_name(domain) ].join('@')
      end
      
      def free_email(name = nil)
        [ user_name(name), fetch('internet.free_email') ].join('@')
      end
      
      def user_name(name = nil)
        return name.scan(/\w+/).shuffle.join(%w(. _).rand).downcase if name
        
        [ 
          Proc.new { Name.first_name.gsub(/\W/, '').downcase },
          Proc.new { 
            [ Name.first_name, Name.last_name ].map {|n| 
              n.gsub(/\W/, '')
            }.join(%w(. _).rand).downcase }
        ].rand.call
      end
      
      def domain_name(domain = nil)
        [ domain_word(domain), domain_suffix ].join('.')
      end
      
      def domain_word(name = nil)
        name = Company.name if name.nil?
        name.split(' ').first.gsub(/\W/, '').downcase
      end
      
      def domain_suffix
        fetch('internet.domain_suffix')
      end
      
      def website(name = nil)
        [ 'www', domain_word(name), domain_suffix ].join('.')
      end
      
      def facebook
        numerify(fetch('internet.facebook'))
      end
      
      def twitter(name = nil)
        "twitter.com/#!/#{user_name(name)}"
      end

      def linkedin(name = nil)
        "www.linkedin.com/in/#{user_name(name)}"
      end
      
      def ip_v4_address
        ary = (2..255).to_a
        [ary.rand,
        ary.rand,
        ary.rand,
        ary.rand].join('.')
      end

      def ip_v6_address
        @@ip_v6_space ||= (0..65535).to_a
        container = (1..8).map{ |_| @@ip_v6_space.rand }
        container.map{ |n| n.to_s(16) }.join(':')
      end
    end
  end
end
