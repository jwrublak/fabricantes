FabricanteType = GraphQL::ObjectType.define do
  name 'Fabricante'
  description 'Quem fabrica'

  field :id, !types.ID
  field :nome, !types.String, property: :nome
  field :codigo, !types.String, property: :codigo
end

ProdutoType = GraphQL::ObjectType.define do
  name 'Produto'
  description 'produto de um fabricante'

  field :id, !types.ID
  field :nome, !types.String, property: :nome
  field :codigo, !types.String, property: :codigo
  field :price, !types.String, property: :price
end

QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The root of all queries'

  field :all_fabricantes do
    type types[FabricanteType]
    description 'Todos os fabricantes'
    resolve -> (obj, args, ctx) { Fabricante.all }
  end

  field :fabricante do
    type FabricanteType
    description 'fabricante dado um ID'
    argument :id, !types.ID
    resolve -> (obj, args, ctx) { Fabricante.find(args[:id]) }
  end

  field :produtos_do_fabricante do
    type types[ProdutoType]
    description 'poduto de um fabricante dado um ID'
    argument :id, !types.ID
    resolve -> (obj, args, ctx) { Fabricante.find(args[:id]).produtos }
  end
end

Schema = GraphQL::Schema.define do
  query QueryType
end
