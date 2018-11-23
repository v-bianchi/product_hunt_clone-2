require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_path

    assert_selector "h1", text: "Products"
    assert_selector ".product-body", count: Product.count
  end

  test "lets a signed in user create a new product" do
    login_as users(:george)
    visit '/products/new'

    # save_and_open_screenshot

    fill_in "product_name", with: "Le Wagon"
    fill_in "product_tagline", with: "Change your life: Learn to code"
    # save_and_open_screenshot

    click_on 'Create Product'
    # save_and_open_screenshot

    # Should be redirected to Home with new product
    assert_equal root_path, page.current_path
    assert_text "Change your life: Learn to code"
  end

  test "does not let a non signed in user create a new product" do
    visit '/products/new'

    # save_and_open_screenshot
    fill_in "product_name", with: "Le Wagon"
    fill_in "product_tagline", with: "Change your life: Learn to code"
    # save_and_open_screenshot

    product_count_before = Product.count
    click_on 'Create Product'
    # save_and_open_screenshot

    # Should be redirected to Home with new product
    assert_equal '/users/sign_in', page.current_path
    assert_equal Product.count, product_count_before
  end
end
