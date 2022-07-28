# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Iron factory
FactoryRate.create(
  kind: :iron, level: 1, production: 10, upgrade_duration: 15,
  upgrade_cost: { iron: 300, copper: 100, gold: 1 }.to_json
)

FactoryRate.create(
  kind: :iron, level: 2, production: 20, upgrade_duration: 30,
  upgrade_cost: { iron: 800, copper: 250, gold: 2 }.to_json
)

# 40/s 60s 1600 iron, 500 copper, 4 gold
FactoryRate.create(
  kind: :iron, level: 3, production: 40, upgrade_duration: 60,
  upgrade_cost: { iron: 1600, copper: 500, gold: 4 }.to_json
)

# 4 80/s 90s 3000 iron, 1000 copper, 8 gold
FactoryRate.create(
  kind: :iron, level: 4, production: 80, upgrade_duration: 90,
  upgrade_cost: { iron: 3000, copper: 1000, gold: 8 }.to_json
)

# 5 150/s 120s
FactoryRate.create(
  kind: :iron, level: 5, production: 150, upgrade_duration: 120
)

# Copper factory
FactoryRate.create(
  kind: :copper, level: 1, production: 3, upgrade_duration: 15,
  upgrade_cost: { iron: 200, copper: 70 }.to_json
)

FactoryRate.create(
  kind: :copper, level: 2, production: 7, upgrade_duration: 30,
  upgrade_cost: { iron: 400, copper: 150 }.to_json
)

FactoryRate.create(
  kind: :copper, level: 3, production: 14, upgrade_duration: 60,
  upgrade_cost: { iron: 800, copper: 300 }.to_json
)

FactoryRate.create(
  kind: :copper, level: 4, production: 30, upgrade_duration: 90,
  upgrade_cost: { iron: 1600, copper: 600 }.to_json
)

FactoryRate.create(
  kind: :copper, level: 5, production: 60, upgrade_duration: 120
)

# Gold factory
FactoryRate.create(
  kind: :gold, level: 1, production: 2, upgrade_duration: 15,
  upgrade_cost: { copper: 100, gold: 2 }.to_json
)

FactoryRate.create(
  kind: :gold, level: 2, production: 3, upgrade_duration: 30,
  upgrade_cost: { copper: 200, gold: 4 }.to_json
)

FactoryRate.create(
  kind: :gold, level: 3, production: 4, upgrade_duration: 60,
  upgrade_cost: { copper: 400, gold: 8 }.to_json
)

FactoryRate.create(
  kind: :gold, level: 4, production: 6, upgrade_duration: 90,
  upgrade_cost: { copper: 800, gold: 16 }.to_json
)

FactoryRate.create(
  kind: :gold, level: 5, production: 8, upgrade_duration: 120
)
