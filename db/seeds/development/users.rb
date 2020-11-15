10.times do |idx|
  User.create(
    name: "test#{idx}",
    email: "test#{idx}@example.com",
    password: "111111",
    password_confirmation: "111111",
    area: "#{idx}",
    experience: "#{idx}",
    stance: "0",
    history: "演奏会#{idx}回",
    introduction: "楽しく演奏したいです"
  )
end
