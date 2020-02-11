require './services/year_validator'
require 'test/unit'
require 'ostruct'

class TestYearValidator < Test::Unit::TestCase
  def test_valid_year
    year_validatable = OpenStruct.new(year: 2010)
    assert_equal(Services::YearValidator.(year_validatable), true)
  end

  def test_invalid_year
    year_validatable = OpenStruct.new(year: 1899)
    assert_equal(Services::YearValidator.(year_validatable), false)

    year_validatable = OpenStruct.new(year: 2023)
    assert_equal(Services::YearValidator.(year_validatable), false)
  end
end
