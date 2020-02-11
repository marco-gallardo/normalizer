require './services/year_sanitizer'
require 'test/unit'
require 'ostruct'

class TestYearSanitizer < Test::Unit::TestCase
  def setup
    @year_sanitizable = OpenStruct.new(year: '2019')
  end

  def test_year_sanitized
    assert_equal(Services::YearSanitizer.(@year_sanitizable), @year_sanitizable.year.to_i)
  end
end
