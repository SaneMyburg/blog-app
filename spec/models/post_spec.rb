require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { Post.new(author_id: 1, title: 'title', text: 'text', comments_counter: 0, likes_counter: 0) }

  before { subject.save }

  it 'new post should be saved in the database' do
    expect(subject).to be_persisted
  end

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not exceed 250 characters' do
    subject.title = 'a' * 255
    expect(subject).to_not be_valid
  end

  it 'text should be present' do
    subject.text = 'a'
    expect(subject).to be_valid
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 1
    expect(subject).to be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = 1
    expect(subject).to be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  describe '#update_user_posts_counter' do
    it 'user_counter' do
      expect(subject.author.posts_counter).to eq(5)
      subject.update_user_posts_counter
      expect(subject.author.posts_counter).to eq(6)
    end
  end

  describe '#recent_comments' do
    it 'returns the most recent comments' do
      comments = double('comments')
      expect(subject).to receive(:comments).and_return(comments)
      expect(comments).to receive(:order).with(created_at: :desc).and_return(comments)
      expect(comments).to receive(:limit).with(5).and_return(comments)

      subject.recent_comments
    end
  end
end
