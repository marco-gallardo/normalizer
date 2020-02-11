module Factories
  class Car
    attr_accessor :maker, :model, :year, :trim

    def initialize(options)
      @maker = options[:make]
      @model = options[:model]
      @year  = options[:year]
      @trim  = options[:trim]
    end
  end
end
