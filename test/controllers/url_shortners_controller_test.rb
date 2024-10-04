require "test_helper"

class UrlShortnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url_shortner = url_shortners(:one)
  end

  test "should get index" do
    get url_shortners_url
    assert_response :success
  end

  test "should get new" do
    get new_url_shortner_url
    assert_response :success
  end

  test "should create url_shortner" do
    assert_difference("UrlShortner.count") do
      post url_shortners_url, params: { url_shortner: { frequency: @url_shortner.frequency, generated_url,: @url_shortner.generated_url,, given_url: @url_shortner.given_url, title: @url_shortner.title } }
    end

    assert_redirected_to url_shortner_url(UrlShortner.last)
  end

  test "should show url_shortner" do
    get url_shortner_url(@url_shortner)
    assert_response :success
  end

  test "should get edit" do
    get edit_url_shortner_url(@url_shortner)
    assert_response :success
  end

  test "should update url_shortner" do
    patch url_shortner_url(@url_shortner), params: { url_shortner: { frequency: @url_shortner.frequency, generated_url,: @url_shortner.generated_url,, given_url: @url_shortner.given_url, title: @url_shortner.title } }
    assert_redirected_to url_shortner_url(@url_shortner)
  end

  test "should destroy url_shortner" do
    assert_difference("UrlShortner.count", -1) do
      delete url_shortner_url(@url_shortner)
    end

    assert_redirected_to url_shortners_url
  end
end
