
admin = User.create!(
  email: "admin@example.com",
  password: "Password1",
  password_confirmation: "Password1"
)

admin.add_role(:staff)

user_one = User.create!(
  email: "user_one@example.com",
  password: "Password1",
  password_confirmation: "Password1"
)

user_two = User.create!(
  email: "user_two@example.com",
  password: "Password1",
  password_confirmation: "Password1"
)

phone_pending = user_one.phones.create!(
  name: "Phone Pending",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :pending
)

phone_approved = user_one.phones.create!(
  name: "Phone Approved",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :approved
)

phone_shipping = user_one.phones.create!(
  name: "Phone Shipping",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :shipping
)

phone_arrived = user_one.phones.create!(
  name: "Phone Arrived",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :arrived
)

phone_evaluating = user_one.phones.create!(
  name: "Phone Evaluating",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :evaluating
)

phone_analysis_sent = user_one.phones.create!(
  name: "Phone Analysis Sent",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :analysis_sent
)

phone_accepted = user_one.phones.create!(
  name: "Phone Analysis Accepted",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :analysis_accepted
)

phone_fixing = user_one.phones.create!(
  name: "Phone Fixing",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :fixing
)

phone_awaiting_shipment = user_one.phones.create!(
  name: "Phone Awaiting Shipment",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :awaiting_shipment
)

phone_awaiting_shipment = user_one.phones.create!(
  name: "Phone Completed",
  problem: Faker::Lorem.sentence,
  phone_type: "IPhone 14",
  state: :completed
)
