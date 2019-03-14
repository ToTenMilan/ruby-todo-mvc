FactoryBot.define do
  factory :todo, class: Todo do
    title { 'default todo'}
    description { 'default todo description' }
    completed { true }
  end

  factory :wash_dishes, parent: :todo do
  	title { 'wash dishes' }
  	description { 'cleanup the whole sink' }
  	completed { false }
  end
end