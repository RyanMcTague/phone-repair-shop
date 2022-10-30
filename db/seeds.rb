

10.times do |n|
  user = User.create!(
    email: Faker::Internet.email,
    password: "Password1",
    password_confirmation: "Password1"
  )

  type = (n % 2) == 0 ? "IPhone": "Galaxy"

  phone = Phone.create!(
    name: "phone" + n.to_s,
    user: user,
    problem: "Problem",
    phone_type: type
  )
end