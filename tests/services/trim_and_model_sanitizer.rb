require './services/trim_and_model_sanitizer'
require 'test/unit'
require 'ostruct'

class TestTrimAndModelSanitizer < Test::Unit::TestCase
  def test_sanitize_blank_trim
    sanitizable = OpenStruct.new(trim: 'blank', model: '')

    Services::TrimAndModelSanitizer.(sanitizable)

    assert_equal(sanitizable.trim, nil)
  end

  def test_sanitize_model
    sanitizable = OpenStruct.new(trim: '', model: 'focus se')

    Services::TrimAndModelSanitizer.(sanitizable)

    assert_equal(sanitizable.model, 'focus')
  end

  def test_sets_uppercased_trim_from_model
    sanitizable = OpenStruct.new(trim: '', model: 'focus se')

    Services::TrimAndModelSanitizer.(sanitizable)

    assert_equal(sanitizable.trim, 'SE')
  end
end
