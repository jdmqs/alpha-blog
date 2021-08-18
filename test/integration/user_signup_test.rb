require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest

  setup do
    #@user = User.last()
    #@user_id = @user.user_id + 1
  end

  test "get new user form and create user" do
    #print @user.user_id
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "Integration_test_user",
                                         email: "Integration_test_user@somewhere.com",
                                         password: "password123" } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match "Integration_test", response.body
  end

  test "get new user form and reject invalid user submission" do
   get "/signup"
   assert_response :success
   assert_no_difference 'User.count' do
     post users_path, params: { user: { username: "Integration_test_user",
                                        email: "Integration_test_user.somewhere.com",
                                        password: "password123" } }
   end
   assert_match "errors", response.body
   assert_select 'div.alert'
   assert_select 'h4.alert-heading'

  end

end
