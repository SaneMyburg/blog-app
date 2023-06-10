require 'rails_helper'

RSpec.describe Like, type: :model do
  User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.',
              posts_counter: 0)
  subject { Like.new(author_id: 1, post_id: 1) }

  before { subject.save }

  it 'new like should be saved in the database' do
    expect(subject).to be_persisted
  end

  it 'should belong to a user' do
    subject.author_id = nil
    expect(subject).to_not be_valid
  end

  it 'should belong to a post' do
    subject.post_id = nil
    expect(subject).to_not be_valid
  end

  describe '#update_post_likes_counter' do
    it 'like increment' do
      expect(subject.post.likes_counter).to eq(1)
      subject.update_post_likes_counter
      expect(subject.post.likes_counter).to eq(2)
    end
  end
end
