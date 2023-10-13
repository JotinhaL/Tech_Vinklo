require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "valid user format" do
    user = User.new(email:"valid@example.com", phone: "1234567890", cpf: "568.912.970-44")
    assert user.valid?, "User format should be valid"
  end

  test "invalid email format" do
    user = User.new(email: "invalid-email", phone: "1234567890", cpf: "568.912.970-44")
    assert_not user.valid?, "Email format should be invalid"
  end

  test "invalid phone format" do
    user = User.new(email:"valid@example.com", phone: "123", cpf: "568.912.970-44")
    assert_not user.valid?, "Phone format should be invalid"
  end

  test "invalid CPF format" do
    user = User.new(email:"valid@example.com", phone: "1234567890", cpf: "111.222.333-44") 
    assert_not user.valid?, "CPF format should be invalid"
  end
end
