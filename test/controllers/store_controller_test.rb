# frozen_string_literal: true
require 'test_helper'

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    assert_select 'nav.side_nav a', minimum: 4
    assert_select 'main ul.catalog li', 3
    assert_select 'h2', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "should show cart after creating cart" do
    get store_index_url
    assert_select 'nav.side_nav#cart', false, 'Cart should not appear before item added'

    assert_difference('LineItem.count') do
      post line_items_url, params: { product_id: products(:ruby).id }
    end

    assert_select '#cart h2', 'Your Cart', 'Cart should show after adding line item'
  end
end
