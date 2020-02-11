require './factories/car.rb'
require './services/trim_and_model_sanitizer.rb'
require './services/year_validator.rb'
require './services/year_sanitizer.rb'
require './interactors/data.rb'

module Services
  module DataNormalizer
    def self.call(options)
      Normalizer.new(options).run!
    end

    class Normalizer
      def initialize(options)
        @original_options = options
        @car              = Factories::Car.new(options)
        @data_interactor  = Interactors::Data.new(@car)
      end

      def run!
        return @original_options \
          unless data_candidate_for_normalization?

        sanitize_data!
        return_normalized_data
      end

      private

      def sanitize_data!
        sanitize_trim_and_model!
        sanitize_year!
        sanitize_maker_and_model
      end

      def data_candidate_for_normalization?
        valid_year? && valid_data?
      end

      def valid_data?
        @data_interactor.valid_data?
      end

      def valid_year?
        YearValidator.(@car)
      end

      def sanitize_trim_and_model!
        TrimAndModelSanitizer.(@car)
      end

      def sanitize_year!
        YearSanitizer.(@car)
      end

      def sanitize_maker_and_model
        @car.maker = @data_interactor.maker
        @car.model = @data_interactor.model
      end

      def return_normalized_data
        {
          year:  @car.year, make:  @car.maker,
          model: @car.model, trim:  @car.trim
        }
      end
    end
  end
end
