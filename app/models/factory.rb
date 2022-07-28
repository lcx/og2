class Factory < ApplicationRecord
  belongs_to :player

  enum kind: { iron: 1, copper: 2, gold: 3 }, _prefix: :kind_is

  def can_upgrade?

  end

  def factory_rate
    FactoryRate.where(kind: kind, level: level).first
  end
end
