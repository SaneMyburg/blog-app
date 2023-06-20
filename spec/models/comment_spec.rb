require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { Comment.new(text: 'This is a comment', author_id: 1, post_id: 1) }

  before { subject.save }

  it 'new comment should be saved in the database' do
    expect(subject).to be_persisted
  end

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  describe '#update_post_comments_counter' do
    it 'increment' do
      expect(subject.post.comments_counter).to eq(4)
      subject.update_post_comments_counter
      expect(subject.post.comments_counter).to eq(4)
    end
  end
end
