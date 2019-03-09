def login
  @user = create(:user)
  visit root_path
  click_link "Log in if you're already a member"
  fill_in 'Email', with: @user.email
  fill_in 'Password', with: @user.password
  click_button 'Log in'
end
