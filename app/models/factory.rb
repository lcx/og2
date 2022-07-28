class Factory < ApplicationRecord
  belongs_to :player

  enum kind: { iron: 1, copper: 2, gold: 3 }, _prefix: :kind_is

  def can_upgrade?
    upgrade_cost = JSON.parse(factory_rate.upgrade_cost)

    kind.each do |metal, _value|
      factory = player.send("#{metal}_factory")
      cost = upgrade_cost.fetch(metal)
      return false if factory.resources < cost
    end
    return true if upgrade_until.nil?

    return false if Time.zone.now < upgrade_until
    true
  end

  def upgrade
    return false unless can_upgrade?

    increment(:level)
    upgrade_cost = JSON.parse(factory_rate.upgrade_cost)

    kind.each do |metal, _value|
      factory = player.send("#{metal}_factory")
      cost = upgrade_cost.fetch(metal)
      factory.decrement!(:resource, cost)
    end

    upgrade_until = nil
  end

  def factory_rate
    FactoryRate.where(kind: kind, level: level).first
  end
end
