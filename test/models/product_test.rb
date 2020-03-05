# frozen_string_literal: true
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  setup do
    @product = Product.new
  end

  test "product attributes can't be empty" do
    assert @product.invalid?
    assert @product.errors[:title].any?
    assert @product.errors[:description].any?
    assert @product.errors[:image_url].any?
    assert @product.errors[:price].any?
  end

  test "product price must be positive" do
    @product.title = 'yoo grape grape grape'
    @product.description = 'heyooo'
    @product.image_url = 'uhyuuuuu.jpg'

    @product.price = -1
    assert @product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], @product.errors[:price]

    @product.price = 0
    assert @product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], @product.errors[:price]

    @product.price = 1.00
    assert @product.valid?
  end

  def new_product(image_url)
    Product.new(title: "My book is a book", description: 'yo', price: 1, image_url: image_url)
  end

  test "check image url" do
    ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif}
    bad = %w{fred.doc fred.gif/more fred.gif.more}

    ok.each do |url|
      assert new_product(url).valid?, "#{url} should be valid"
    end

    bad.each do |url|
      assert new_product(url).invalid?, "#{url} should be invalid"
    end
  end

  # with fixtures
  test 'product not valid without a unique title' do
    product = Product.new(title: products(:ruby).title, description: 'lol', image_url: 'you.jpg')
    assert product.invalid?
    assert_equal ['has already been taken'], product.errors[:title]
  end
end
