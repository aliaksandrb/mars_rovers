require 'minitest/autorun'

require 'error'
require 'mars_plateu'

class TestMarsPlateu < Minitest::Test
  def test_should_be_initialized_with_coordinates
    assert_raises(Mars::Error) { Mars::MarsPlateu.new }
  end

  def test_initialized_with_coordinates
    mars = Mars::MarsPlateu.new(1, 5)
    assert_equal 1, mars.x
    assert_equal 5, mars.y
  end

  def test_shoul_be_initialized_with_postitive_numbers
    assert_raises(Mars::Error) { Mars::MarsPlateu.new('xfdsf', 5) }
  end

end
