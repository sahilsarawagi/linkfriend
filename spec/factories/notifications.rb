FactoryBot.define do
  factory :notification do
    recipient_id { 1 }
    actor_id { 1 }
    viewed { false }
    action { "MyString" }
    notifiable_id { 1 }
    notifiable_type { "MyString" }
  end
end
