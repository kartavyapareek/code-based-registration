after :roles do
  u = User.find_by email: "admin@admin.com"
  if not u
    u = User.create(
      email: "admin@admin.com",
      first_name: "First",
      last_name: "last_name",
      password: "admin123",
      password_confirmation: "admin123"
    )
  end
  u.roles.push(Role.find_by_name("admin"))
end
