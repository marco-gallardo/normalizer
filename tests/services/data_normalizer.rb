require './services/data_normalizer'
require 'test/unit'

class TestServicesDataNormalizer < Test::Unit::TestCase
  def setup
    @data_to_normalize = [
      [{ :year => '2018', :make => 'fo', :model => 'focus', :trim => 'blank' }, { :year => 2018, :make => 'Ford', :model => 'Focus', :trim => nil }],
      [{ :year => '200', :make => 'blah', :model => 'foo', :trim => 'bar' }, { :year => '200', :make => 'blah', :model => 'foo', :trim => 'bar' }],
      [{ :year => '1999', :make => 'Chev', :model => 'IMPALA', :trim => 'st' }, { :year => 1999, :make => 'Chevrolet', :model => 'Impala', :trim => 'ST' }],
      [{ :year => '2000', :make => 'ford', :model => 'focus se', :trim => '' }, { :year => 2000, :make => 'Ford', :model => 'Focus', :trim => 'SE' }]
    ]
  end

  def test_data_normalized
    @data_to_normalize.each do |(data, expected_output)|
      normalized_data = Services::DataNormalizer.(data)
      assert_equal(normalized_data, expected_output)
    end
  end
end
