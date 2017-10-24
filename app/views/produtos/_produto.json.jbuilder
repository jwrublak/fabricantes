json.extract! produto, :id, :nome, :codigo, :price, :created_at, :updated_at
json.url fabricante_produto_url(produto.fabricante_id, produto, format: :json)
