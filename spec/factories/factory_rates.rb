FactoryBot.define do
  factory :factory_rate do
    level { 1 }
    kind { :iron }
    production { 10 }
    upgrade_duration { 15 }
    upgrade_cost { '{"iron":300,"copper":100,"gold":1}' }
  end
end
