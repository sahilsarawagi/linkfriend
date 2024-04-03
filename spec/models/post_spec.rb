require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end
  end
  describe 'Photo Attachment' do
    let(:post) { create(:post) }
    it 'is valid' do
      expect(post.photo).to be_attached
    end
  end
  context 'Associations' do
    it 'has_many comments' do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq :has_many
      expect(association.options[:dependent]).to eq :destroy
    end
  end
  
end