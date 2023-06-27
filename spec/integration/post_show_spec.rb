require 'rails_helper'

RSpec.describe 'Post show Page', type: :feature do
  describe 'Viewing Post Show page' do
    before(:each) do
      @user1 = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                           posts_counter: 0)
      @first_post = Post.create(author: @user1, title: 'post1', text: 'This is my first post', likes_counter: 0,
                                comments_counter: 0)
      @comment1 = Comment.create(post: @first_post, author: @user1, text: 'Hi Tom!, Nice comment')

      visit "/users/#{@user1.id}/posts/#{@first_post.id}"
    end

    it 'should show post title' do
      expect(page).to have_content(@first_post.title)
    end

    it 'should show post text' do
      expect(page.html).to include(@first_post.text)
    end

    it 'should show comment text ' do
      expect(page).to have_content(@comment1.text)
    end

    it 'should show comments counter' do
      expect(page).to have_content(@first_post.comments_counter)
    end

    it 'should show likes counter' do
      expect(page).to have_content(@first_post.likes_counter)
    end

    it 'should show name of commenter' do
      expect(page).to have_content(@comment1.author.name)
    end
  end
end
