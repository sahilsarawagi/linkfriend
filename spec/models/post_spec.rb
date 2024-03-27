require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end
  end
  describe 'Attachment' do
    let(:post) { create(:post) }
    it 'is valid' do
      expect(post.photo).to be_attached
    end
  end
  
end