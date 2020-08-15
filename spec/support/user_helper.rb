module UserHelper
  def log_in(user)
    visit login_path

    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_on 'submit'
    end
  end
end
