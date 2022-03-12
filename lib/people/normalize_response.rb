module People
  class NormalizeResponse
    def initialize(collection, order)
      @collection = collection
      @order = order
    end

    def call
      prepare_collection
    end
    
    private
    
    attr_reader :collection, :order

    def prepare_collection
      collection.sort_by { |a| a[order.to_s] }.each_with_object([]) do |user_details, r|
        date = Date.parse(user_details['birthdate'])
        r << [user_details['first_name'], abbr_to_city_name(user_details['city']), "#{date.month}/#{date.day}/#{date.year}"].join(', ')
      end
    end
    
    def abbr_to_city_name(value)
      abbr_city_mappings[value] != nil ? abbr_city_mappings[value] : value
    end
    
    def abbr_city_mappings
      {
        'LA' => 'Los Angeles',
        'NYC' => 'New York City'
      }
    end
  end  
end
