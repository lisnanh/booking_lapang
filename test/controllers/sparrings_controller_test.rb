require "test_helper"

class SparringsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sparring = sparrings(:one)
  end

  test "should get index" do
    get sparrings_url
    assert_response :success
  end

  test "should get new" do
    get new_sparring_url
    assert_response :success
  end

  test "should create sparring" do
    assert_difference("Sparring.count") do
      post sparrings_url, params: { sparring: {  } }
    end

    assert_redirected_to sparring_url(Sparring.last)
  end

  test "should show sparring" do
    get sparring_url(@sparring)
    assert_response :success
  end

  test "should get edit" do
    get edit_sparring_url(@sparring)
    assert_response :success
  end

  test "should update sparring" do
    patch sparring_url(@sparring), params: { sparring: {  } }
    assert_redirected_to sparring_url(@sparring)
  end

  test "should destroy sparring" do
    assert_difference("Sparring.count", -1) do
      delete sparring_url(@sparring)
    end

    assert_redirected_to sparrings_url
  end
end
