require 'spec_helper'

RSpec.describe 'Details Parser Library Functional Tests' do
  describe 'Parsed User Details' do
    let(:details_parser) { People::DetailsParser.new(File.read('spec/fixtures/people_by_dollar.txt'), :dollar_format) }

    it 'parses input files and outputs normalized data' do
      parsed_details = details_parser.call
      collection = [{"city"=>"LA", 
                     "birthdate"=>"30-4-1974", 
                     "last_name"=>"Nolan", 
                     "first_name"=>"Rhiannon"}, 
                    {"city"=>"NYC", 
                     "birthdate"=>"5-1-1962", 
                     "last_name"=>"Bruen", 
                     "first_name"=>"Rigoberto"}]
      expect(parsed_details).to eq(collection)
    end
  end
end
