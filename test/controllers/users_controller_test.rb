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

  test "search_user returns all users when no query is provided" do
    get search_user_path
    assert_response :success
    assert_template 'search_user'
    assert_not_nil assigns(:users)
    assert_equal User.all, assigns(:users)
  end

  test "search_user returns users by name" do
    user = User.create(name: "User 1", email: "user1@example.com", cpf: "568.912.970-44", phone: "1234567890")    

    get search_user_path, params: { query: 'User', search_option: 'name' }
    assert_response :success
    assert_template 'search_user'
    assert_not_nil assigns(:users)
    assert_equal [user], assigns(:users)
  end

  test "search_user returns users by CPF" do
    user = User.create(name: "User 1", email: "user1@example.com", cpf: "568.912.970-44", phone: "1234567890") 
    get search_user_path, params: { query: '568.912.970-44', search_option: 'cpf' }
    assert_response :success
    assert_template 'search_user'
    assert_not_nil assigns(:users)
    assert_equal [user], assigns(:users)
  end

  test "search_user returns users by email" do
    user = User.create(name: "User 1", email: "user1@example.com", cpf: "568.912.970-44", phone: "1234567890") 

    get search_user_path, params: { query: 'user1@example.com', search_option: 'email' }
    assert_response :success
    assert_template 'search_user'
    assert_not_nil assigns(:users)
    assert_equal [user], assigns(:users)
  end

  test "search_user returns users by phone" do
    user = User.create(name: "User 1", email: "user1@example.com", cpf: "568.912.970-44", phone: "1234567890") 
    get search_user_path, params: { query: '1234567890', search_option: 'phone' }
    assert_response :success
    assert_template 'search_user'
    assert_not_nil assigns(:users)
    assert_equal [user], assigns(:users)
  end
  
  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
