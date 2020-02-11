module Services
  module YearSanitizer
    def self.call(year_validable)
      year_validable.year = year_validable.year.to_i
    end
  end
end
