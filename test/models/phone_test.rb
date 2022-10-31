require "test_helper"

class PhoneTest < ActiveSupport::TestCase
  setup do
    @user = User.find_by(email: "user_one@example.com")
    @phones = @user.phones
  end
  
  test "has valid testing data" do
    Phone.find_each do |phone|
      assert_valid phone
    end
  end

  test "is valid on valid attributes" do
    phone = Phone.new(
      user: @user,
      name: "Test Phone",
      phone_type: "IPhone 14",
      problem: "problem here..."
    )
    assert_valid phone
  end

  test "is invalid with invalid name" do
    # is nil
    phone = Phone.first
    phone.name= nil
    refute_valid phone

    # not unique
    phone = Phone.first
    phone.name = Phone.last.name
    refute_valid phone

    # too short
    phone = Phone.first
    phone.name =  "."
    refute_valid phone

    # too long
    phone = Phone.first
    phone.name =  "." * 26
    refute_valid phone
  end

  test "is invalid with invalid phone type" do
    # is nil
    phone = Phone.first
    phone.phone_type= nil
    refute_valid phone
  end

  test "is invalid with invalid problem" do
    # is nil
    phone = Phone.first
    phone.problem = nil
    refute_valid phone
  end

  test "creates :phone_owner role after create" do
    phone = Phone.create!(
      user: @user,
      name: "Test Phone",
      phone_type: "IPhone 14",
      problem: "problem here..."
    )
    user = User.with_role(:phone_owner, phone).first
    assert_equal @user, user
  end

  test ":reset transitions to pending on valid state" do
    @phones.each do |phone|
      if phone.pending?
        refute phone.reset, ":reset should not be transition"
      else
        phone.reset
        phone.reload
        assert phone.pending?, ":state should be pending"
      end
    end
  end

  test ":approve transitions to approved on valid state" do
    @phones.each do |phone|
      if phone.pending?
        phone.approve
        phone.reload
        assert phone.approved?, ":state should be approved"
      else
        refute phone.approve , ":approve should not be transition for #{phone.state} phone"
      end
    end
  end

  test ":ship transitions to shipping on valid state" do
    @phones.each do |phone|
      if phone.awaiting_shipment?
        phone.ship
        phone.reload
        assert phone.shipping?, ":state should be shipped"
      else
        refute phone.ship , ":approve should not be transition for #{phone.state} phone"
      end
    end
  end

  test ":arrive transitions to arrived on valid state" do
    @phones.each do |phone|
      if phone.shipping?
        phone.arrive
        phone.reload
        assert phone.arrived?, ":state should be arrived"
      else
        refute phone.arrive , ":approve should not be transition for #{phone.state} phone"
      end
    end
  end

  test ":evaluate transitions to evaluating on valid state" do
    @phones.each do |phone|
      if phone.arrived?
        phone.evaluate
        phone.reload
        assert phone.evaluating?, ":state should be evaluating"
      else
        refute phone.evaluate , ":evaluate should not be transition for #{phone.state} phone"
      end
    end
  end

  test ":send_analysis transitions to analysis_sent on valid state" do
    @phones.each do |phone|
      if phone.evaluating?
        phone.send_analysis
        phone.reload
        assert phone.analysis_sent?, ":state should be analysis_sent"
      else
        refute phone.send_analysis , ":send_analysis should not be transition for #{phone.state} phone"
      end
    end
  end

  test ":accept_analysis transitions to analysis_accepted on valid state" do
    @phones.each do |phone|
      if phone.analysis_sent?
        phone.accept_analysis
        phone.reload
        assert phone.analysis_accepted?, ":state should be analysis_sent"
      else
        refute phone.accept_analysis , ":accept_analysis should not be transition for #{phone.state} phone"
      end
    end
  end

  test ":fix transitions to fixing on valid state" do
    @phones.each do |phone|
      if phone.analysis_accepted?
        phone.fix
        phone.reload
        assert phone.fixing?, ":state should be fixing"
      else
        refute phone.fix, ":fix should not be transition for #{phone.state} phone"
      end
    end
  end

  test ":await_shipment transitions to awaiting_shipment on valid state" do
    @phones.each do |phone|
      if phone.accepted? || phone.fixing?
        phone.await_shipment
        phone.reload
        assert phone.awaiting_shipment?, ":state should be awaiting_shipment"
      else
        refute phone.await_shipment , ":await_shipment should not be transition for #{phone.state} phone"
      end
    end
  end

  test ":complete transitions to completed on valid state" do
    @phones.each do |phone|
      if phone.shipping?
        phone.complete
        phone.reload
        assert phone.completed?, ":state should be completed"
      else
        refute phone.complete , ":complete should not be transition for #{phone.state} phone"
      end
    end
  end

  test ":can_update? returns correct value" do
    @phones.each do |phone|
      if phone.pending?
        assert phone.can_update?, ":can_update? should return true for #{phone.state} phone"
      else
        refute phone.can_update?, ":can_update? should return false for #{phone.state} phone"
      end
    end
  end

  test ":can_destroy? returns correct value" do
    @phones.each do |phone|
      if phone.pending? || phone.completed?
        assert phone.can_destroy?, ":can_destroy? should return true for #{phone.state} phone"
      else
        refute phone.can_destroy?, ":can_destroy? should return false for #{phone.state} phone"
      end
    end
  end
end
