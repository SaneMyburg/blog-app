require 'rails_helper'
RSpec.describe 'Post Index Page', type: :feature do
  describe 'Viewing Post Index page' do
    before(:each) do
      @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                           posts_counter: 0)
      @first_post = Post.create(author: @user1, title: 'post1', text: 'This is my first post', likes_counter: 0,
                                comments_counter: 0)
      @comment1 = Comment.create(post: @first_post, author: @user1, text: 'Hi Tom!, Nice comment')
      visit user_posts_path(@user1)
    end
    it 'should show user name' do
      expect(page).to have_content(@user1.name)
    end
    it 'should show user photo' do
      expect(page.html).to include(@user1.photo)
    end
    it 'should show posts_counter of clicked user' do
      expect(page).to have_content(@user1.posts_counter)
    end
    it 'should show all posts' do
      expect(page).to have_content(@first_post.title)
    end
    it 'should show post text' do
      expect(page).to have_content(@first_post.text)
    end
    it 'should show comment text' do
      expect(page).to have_content(@comment1.text)
    end
    it 'should show comments counter' do
      expect(page).to have_content(@first_post.comments_counter)
    end
    it 'should show likes counter' do
      expect(page).to have_content(@first_post.likes_counter)
    end
    it 'should show a button for pagination if there are more posts than fit on the view.' do
      visit user_posts_path(@user1.id)
      expect(page).to have_button('Pagination')
    end
  end
end
