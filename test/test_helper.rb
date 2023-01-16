# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'hexlet_code'

require 'minitest'
require 'minitest/autorun'
require 'minitest/power_assert'

class TestCase < MiniTest::Test
  def load_fixture(filename)
    File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
  end

  def make_html_oneline(html)
    html.split("\n").map(&:strip).join
  end
end
