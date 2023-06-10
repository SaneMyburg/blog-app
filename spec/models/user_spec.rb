require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Chelsea', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: nil) }

  before { subject.save }

  it 'new user should be saved in the database' do
    expect(subject.new_record?).to be_truthy
  end

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be an integer' do
    subject.posts_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be greater than or equal to 0' do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  describe '.recent_posts' do
    let(:user) { User.create(name: 'John') }

    it 'returns the most recent 3 posts of the user' do
      recent_posts = [
        Post.create(title: 'First Post', text: 'Hello', comments_counter: 0, likes_counter: 0, author: user,
                    created_at: 3.days.ago),
        Post.create(title: 'Second Post', text: 'World', comments_counter: 0, likes_counter: 0, author: user,
                    created_at: 2.days.ago),
        Post.create(title: 'Third Post', text: 'Test', comments_counter: 0, likes_counter: 0, author: user,
                    created_at: 1.day.ago)
      ]

      recent_posts.each { |post| post.update(author_id: user.id) }

      expected = recent_posts.map do |post|
        post.attributes.slice('id', 'title', 'text', 'comments_counter', 'likes_counter', 'author_id', 'created_at',
                              'updated_at')
      end
      actual = User.recent_posts(user).map do |post|
        post.attributes.slice('id', 'title', 'text', 'comments_counter', 'likes_counter', 'author_id', 'created_at',
                              'updated_at')
      end

      expected.sort_by! { |post| post['created_at'] }
      actual.sort_by! { |post| post['created_at'] }

      expect(expected).to eq(actual)
      expect(actual.all? { |post| post['author_id'] == user.id }).to be_truthy
    end
  end
end
