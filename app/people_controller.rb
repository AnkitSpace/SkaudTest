class PeopleController
  require 'date'
  require './lib/people/details_parser'
  require './lib/people/normalize_response'
  
  def initialize(params)
    @params = params
  end

  def normalize
    collection = formats.keys.reduce([]) { |r, format| r + user_parsed_details(format.to_sym) }
    People::NormalizeResponse.new(collection, params[:order]).call
  end

  private

  attr_reader :params

  def normalize_response(collection)
    collection.sort_by { |a| a[params[:order].to_s] }.each_with_object([]) do |user_details, r|
      date = Date.parse(user_details['birthdate'])
      r << [user_details['first_name'], abbr_to_city_name(user_details['city']), "#{date.month}/#{date.day}/#{date.year}"].join(', ')
    end
  end

  def user_parsed_details(details_format)
    People::DetailsParser.new(params[details_format], details_format).call
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

  def formats
    params.select { |param_key, val| param_key.to_s.include?('_format') }
  end
end
