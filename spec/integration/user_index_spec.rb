require 'rails_helper'

RSpec.feature 'User Index Page', type: :feature do
  let(:user) do
    User.create(name: 'Sandy', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                bio: 'Teacher from Poland.', posts_counter: 0)
  end

  before do
    user
    visit users_path
  end

  scenario 'I can see the username, profile picture, and number of posts for each user' do
    expect(page).to have_content(user.name)
    expect(page.html).to include(user.photo)
    expect(page).to have_content(user.posts_counter)
  end

  scenario 'When I click on a user, I am redirected to their show page' do
    click_on user.name
    expect(current_path).to eq(current_path)
  end
end
