class Player < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, :recoverable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :factories, dependent: :destroy

  before_create :create_player_factories

  def iron_factory
    factories.where(kind: :iron).first
  end

  def copper_factory
    factories.where(kind: :copper).first
  end

  def gold_factory
    factories.where(kind: :gold).first
  end

  private

  def create_player_factories
    Factory.kinds.each do |kind, _value|
      factories << Factory.new(kind: kind)
    end
  end
end
