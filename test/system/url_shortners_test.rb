require "application_system_test_case"

class UrlShortnersTest < ApplicationSystemTestCase
  setup do
    @url_shortner = url_shortners(:one)
  end

  test "visiting the index" do
    visit url_shortners_url
    assert_selector "h1", text: "Url shortners"
  end

  test "should create url shortner" do
    visit url_shortners_url
    click_on "New url shortner"

    fill_in "Frequency", with: @url_shortner.frequency
    fill_in "Generated url,", with: @url_shortner.generated_url,
    fill_in "Given url", with: @url_shortner.given_url
    fill_in "Title", with: @url_shortner.title
    click_on "Create Url shortner"

    assert_text "Url shortner was successfully created"
    click_on "Back"
  end

  test "should update Url shortner" do
    visit url_shortner_url(@url_shortner)
    click_on "Edit this url shortner", match: :first

    fill_in "Frequency", with: @url_shortner.frequency
    fill_in "Generated url,", with: @url_shortner.generated_url,
    fill_in "Given url", with: @url_shortner.given_url
    fill_in "Title", with: @url_shortner.title
    click_on "Update Url shortner"

    assert_text "Url shortner was successfully updated"
    click_on "Back"
  end

  test "should destroy Url shortner" do
    visit url_shortner_url(@url_shortner)
    click_on "Destroy this url shortner", match: :first

    assert_text "Url shortner was successfully destroyed"
  end
end
