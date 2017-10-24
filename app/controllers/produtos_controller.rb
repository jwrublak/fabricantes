require 'net/http'
require 'json'

class ProdutosController < ApplicationController
  before_action :load_produtos_list, only: [:new]
  before_action :set_produto, only: [:show, :edit, :update, :destroy]
  before_action :load_fabricante

  # GET /produtos
  # GET /produtos.json
  def index
    @produtos = @fabricante.produtos.all
  end

  # GET /produtos/1
  # GET /produtos/1.json
  def show
  end

  # GET /produtos/new
  def new
    @produto = Produto.new
  end

  # GET /produtos/1/edit
  def edit
  end

  # POST /produtos
  # POST /produtos.json
  def create
    old_produto = Produto.new
    @produto = @fabricante.produtos.build produto_params

    respond_to do |format|
      if @produto.save
        store_changes old_produto, @produto
        format.html { redirect_to fabricante_produto_path(@fabricante, @produto), notice: 'Produto was successfully created.' }
        format.json { render :show, status: :created, location: @produto }
      else
        format.html { render :new }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /produtos/1
  # PATCH/PUT /produtos/1.json
  def update
    old_produto = Produto.new @produto.attributes

    respond_to do |format|
      if @produto.update(produto_params)
        store_changes old_produto, @produto
        format.html { redirect_to fabricante_produto_path(@fabricante, @produto), notice: 'Produto was successfully updated.' }
        format.json { render :show, status: :ok, location: @produto }
      else
        format.html { render :edit }
        format.json { render json: @produto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /produtos/1
  # DELETE /produtos/1.json
  def destroy
    @produto.destroy
    respond_to do |format|
      format.html { redirect_to fabricante_produtos_path(@fabricante), notice: 'Produto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def load_produtos_list
      @produtos_from_service = []

      url = URI.parse('http://produtos.g.schiar.vms.ufsc.br:3000/produtos.json')
      req = Net::HTTP::Get.new(url.to_s)
      req.basic_auth 'giovani@schiar.com', 'lalala'
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }

      JSON.parse(res.body).each do |produto_s|
        @produtos_from_service.push Produto.new({id:produto_s['id'], nome: produto_s['name'], codigo: produto_s['code']})
      end

    end

    def load_fabricante
      @fabricante = Fabricante.find(params[:fabricante_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_produto
      @produto = Produto.find(params[:id])
      puts '-' * 100
      puts @produto.inspect
      puts '-' * 100
    end

    def set_produto_from_service
      @produto = @produtos_from_service.detect {|item| params[:id].to_i == item.id}
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def produto_params
      params.require(:produto).permit(:nome, :codigo, :price, :fabricante_id)
    end
end
