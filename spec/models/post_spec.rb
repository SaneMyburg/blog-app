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
    subject.text = nil
    expect(subject).to be_valid
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = 'a'
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be greater than or equal to 0' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end
end
