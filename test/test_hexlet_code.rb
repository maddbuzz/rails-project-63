# frozen_string_literal: true

require 'test_helper'

# autoload('HexletCode', "#{__dir__}/../lib/hexlet_code.rb")

class TestHexletCode < TestCase
  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  User = Struct.new(:name, :job, :gender, keyword_init: true)
  def setup
    @user = User.new name: 'rob', job: 'hexlet', gender: 'm'
  end

  def make_html_oneline(html)
    html.split("\n").map(&:strip).join
  end

  def test_form_for1
    expected_html = make_html_oneline(load_fixture('expected1.html'))
    actual_html =
      HexletCode.form_for @user do |f|
        f.input :name
        f.input :job, as: :text
      end
    assert { actual_html == expected_html }
  end

  def test_form_for2
    expected_html = make_html_oneline(load_fixture('expected2.html'))
    actual_html =
      HexletCode.form_for @user, url: '#' do |f|
        f.input :name, class: 'user-input'
        f.input :job
      end
    assert { actual_html == expected_html }
  end

  def test_form_for3
    expected_html = make_html_oneline(load_fixture('expected3.html'))
    actual_html =
      HexletCode.form_for @user do |f|
        f.input :job, as: :text
        f.submit
      end
    assert { actual_html == expected_html }
  end

  def test_form_for4
    expected_html = make_html_oneline(load_fixture('expected4.html'))
    actual_html =
      HexletCode.form_for @user, url: '/users' do |f|
        f.input :job, as: :text, rows: 50, cols: 50
        f.submit 'Wow'
      end
    assert { actual_html == expected_html }
  end

  def test_form_for_missing_field
    assert_raises NoMethodError do
      HexletCode.form_for @user do |f|
        f.input :age
      end
    end
  end
end
