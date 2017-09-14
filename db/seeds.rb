# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

fabricante = Fabricante.create(nome: 'Ford', codigo: 234)
Produto.create(nome: 'Ka', codigo: 22, fabricante_id: fabricante.id)
Produto.create(nome: 'Fiesta', codigo: 24, fabricante_id: fabricante.id)
Produto.create(nome: 'Focus', codigo: 25, fabricante_id: fabricante.id)