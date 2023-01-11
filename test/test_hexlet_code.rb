# frozen_string_literal: true

require 'test_helper'

# autoload('HexletCode', "#{__dir__}/../lib/hexlet_code.rb")

class TestHexletCode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  # def test_tag_build
  #   assert { HexletCode::Tag.build('br') == '<br>' }
  #   assert { HexletCode::Tag.build('img', src: 'path/to/image') == '<img src="path/to/image">' }
  #   assert { HexletCode::Tag.build('input', type: 'submit', value: 'Save') == '<input type="submit" value="Save">' }
  # end

  def setup
    user_class = Struct.new(:name, :job, keyword_init: true)
    @user = user_class.new name: 'rob'
  end

  def test_form_for
    actual_form = nil

    HexletCode.form_for @user do |f|
      actual_form = f
    end
    assert { actual_form == '<form action="#" method="post"></form>' }

    HexletCode.form_for @user, url: '/users' do |f|
      actual_form = f
    end
    assert { actual_form == '<form action="/users" method="post"></form>' }
  end
end
