module People
  class DetailsParser
    def initialize(formatted_string, format_type)
      @formatted_string = formatted_string
      @format_type = format_type
      @formatted_values = formatted_string.split("\n")
    end

    def call
      parsed_object_collection
    end
    
    private
    
    attr_reader :formatted_string, :format_type, :formatted_values

    def parsed_object_collection
      result = []
      formatted_values[1..formatted_values.count].each do |formatted_value|
        values = formatted_value.split(values_separator)
        result << values.each_with_object({}) do |value, r|
          r[headers[values.index(value)]] = value
        end
      end
      result
    end

    def headers
      formatted_values[0].split(values_separator)
    end

    def values_separator
      @values_separator ||= format_type.to_s == 'dollar_format' ? ' $ ' : ' % '
    end
  end  
end
