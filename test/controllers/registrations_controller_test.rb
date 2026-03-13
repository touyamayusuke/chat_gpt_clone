require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create account" do
    post registration_url, params: {
      email_address: "new-user@example.com",
      password: "password123"
    }

    assert_response :see_other
  end
end
