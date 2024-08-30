require "application_system_test_case"

class SparringsTest < ApplicationSystemTestCase
  setup do
    @sparring = sparrings(:one)
  end

  test "visiting the index" do
    visit sparrings_url
    assert_selector "h1", text: "Sparrings"
  end

  test "should create sparring" do
    visit sparrings_url
    click_on "New sparring"

    click_on "Create Sparring"

    assert_text "Sparring was successfully created"
    click_on "Back"
  end

  test "should update Sparring" do
    visit sparring_url(@sparring)
    click_on "Edit this sparring", match: :first

    click_on "Update Sparring"

    assert_text "Sparring was successfully updated"
    click_on "Back"
  end

  test "should destroy Sparring" do
    visit sparring_url(@sparring)
    click_on "Destroy this sparring", match: :first

    assert_text "Sparring was successfully destroyed"
  end
end
