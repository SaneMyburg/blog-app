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
end
