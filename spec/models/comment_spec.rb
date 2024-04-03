require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end
  end
  context 'Associations' do
    it 'belongs_to post' do
      association = described_class.reflect_on_association(:post).macro
      expect(association).to eq :belongs_to
    end
  end
end
