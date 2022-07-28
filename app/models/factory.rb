class Factory < ApplicationRecord
  belongs_to :player

  enum kind: { iron: 1, copper: 2, gold: 3 }, _prefix: :kind_is
end
