require "rails_helper"

feature "Can log out as registered user" do

  scenario "registered user logs out, cant see logout when logged out" do
    test_setup
    
    visit root_path
    within("#login-button") do
      click_link "Login"
    end

    expect(current_path).to eq(login_path)

    fill_in "Username", with: user.username
    fill_in "Password", with: "password"
    click_button "Login"

    expect(page).to have_content("Donald Trump")

    click_link "Logout"

    within("#navbar-flash") do
      expect(page).to_not have_content("Logout")
      expect(page).to have_content("Login")
      expect(page).to have_content("Join")
    end
  end
end
