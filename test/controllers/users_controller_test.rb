require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { cpf: "568.912.970-44", email: "new_user@example.com", name: "New User", phone: "1234567890" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    updated_user = @user.dup
    updated_user.cpf = "568.912.970-44"
    updated_user.email = "test@hotmail.com"
    updated_user.name = "New Name"
    updated_user.phone = "1234567890"
    patch user_url(@user), params: { user: { cpf: updated_user.cpf, email: updated_user.email, name: updated_user.name, phone: updated_user.phone } }
    assert_redirected_to user_url(@user)
  end

  test "should search users" do
    user1 = User.create(name: "User 1", email: "user1@example.com", cpf: "568.912.970-44", phone: "1234567890")
    user2 = User.create(name: "User 2", email: "user2@example.com", cpf: "708.476.600-60", phone: "0987654321")

    get search_user_path(query: "User 1") 
    assert_response :success  

    assert_select 'body', /user1@example.com/ 
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
