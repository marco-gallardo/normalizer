require './interactors/data'
require './factories/car'
require 'test/unit'
require 'ostruct'

class TestData < Test::Unit::TestCase
  def setup
    @data_interactable = Factories::Car.new(
      {
        make: 'ford',
        model: 'focus',
        trim:  'se',
        year:   2010
      }
    )
  end

  def test_maker_attr
    data_interactor = Interactors::Data.new(@data_interactable)
    assert_equal(data_interactor.maker, 'Ford')
  end

  def test_model_attr
    data_interactor = Interactors::Data.new(@data_interactable)
    assert_equal(data_interactor.model, 'Focus')
  end

  def test_valid_data_returns_true
    data_interactor = Interactors::Data.new(@data_interactable)
    assert_equal(data_interactor.valid_data?, true)
  end

  def test_valid_data_returns_false
    [
      ['invalid_maker','focus'],
      ['ford', 'invalid_model'],
      ['invalid_maker', 'invalid_model']
    ].each do |maker, model|
      @data_interactable.maker = maker
      @data_interactable.model = model

      data_interactor = Interactors::Data.new(@data_interactable)
      assert_equal(data_interactor.valid_data?, false)
    end
  end
end
