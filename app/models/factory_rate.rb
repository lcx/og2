class FactoryRate < ApplicationRecord
  validates :kind, presence: true
  validates :level, presence: true
  validates :production, presence: true
  validates :upgrade_duration, presence: true

  enum kind: { iron: 1, copper: 2, gold: 3 }, _prefix: :kind_is
end
