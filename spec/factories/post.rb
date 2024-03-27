FactoryBot.define do
  factory :post do
    # Define other attributes of the Post model here
    body { 'Sample Post' }
    user { association :user }
    after :build do |post|
      file_path = Rails.root.join('spec/fixtures/sample.jpeg')
      post.photo.attach(io: File.open(file_path), filename: 'sample.jpeg', content_type: 'image/*')
    end
  end
end
