require 'Time'

module Services
  module YearValidator
    def self.call(year_validatable)
      Validator.new(year_validatable).valid?
    end

    class Validator
      def initialize(year_validatable)
        @year_validatable = year_validatable
      end

      def valid?
        valid_year_in_future? && valid_year_in_past?
      end

      private

      def valid_year_in_future?
        year_integer_formatted <= valid_max_year_in_future
      end

      def valid_year_in_past?
        year_integer_formatted >= valid_max_year_in_past
      end

      def year_integer_formatted
        @year_validatable.year.to_i
      end

      def valid_max_year_in_future
        @valid_max_year_in_future ||= Time.now.year + 2
      end

      def valid_max_year_in_past
        @valid_max_year_in_past ||= 1900
      end
    end
  end
end
