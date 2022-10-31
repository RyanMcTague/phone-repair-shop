require "test_helper"

class PhonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @staff = User.with_role(:staff).first
    @user = User.find_by(email: "user_one@example.com")
    @phones = @user.phones
    sign_in @user
  end
end
