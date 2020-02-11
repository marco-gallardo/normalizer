require './fixtures/cars_list.rb'

# On a real life case this shouldn't be that
# messy due to use of ORM/ODM's methods
module Interactors
  class Data
    include CarsList

    attr_reader :maker, :model

    def initialize(data_interactable)
      @data_interactable = data_interactable

      after_initialize
    end

    def valid_data?
      @valid_data ||= !@maker.nil? && !@model.nil?
    end

    private

    def after_initialize
      find_car_by_maker_and_model
    end

    def find_car_by_maker_and_model
      cars_list.each do |listed_car|
        @maker = find({type: :maker, listed_maker: listed_car[:maker]})
        @model = find({type: :model, listed_models: listed_car[:models]})

        break if @maker && @model
      end
    end

    def cars_list
      @cars_list ||= CARS_LIST
    end

    def find(options)
      if options[:type] == :maker
        options[:listed_maker] if maker_matches?(options[:listed_maker])
      else
        find_model_from(options[:listed_models])
      end
    end

    def maker_matches?(listed_maker)
      maker_match_1 = (listed_maker =~ regexped(@data_interactable.maker))
      maker_match_2 = (@data_interactable.maker =~ regexped(listed_maker))

      maker_match_1 == 0 || maker_match_2 == 0
    end

    def find_model_from(models_list)
      models_list.select do |model|
        (model =~ regexped(cleanned_model)).zero? rescue nil
      end.first
    end

    def regexped(word)
      Regexp.new(word, Regexp::IGNORECASE)
    end

    def cleanned_model
      @cleanned_model ||= @data_interactable.model.split(' ').first
    end
  end
end
