class ProdutosController < ApplicationController

	def index
		@produtos_por_nome = Produto.order(:nome).limit 5
		@produtos_por_preco = Produto.order(:preco).limit 2
	end

	def new
		@produto = Produto.new
	end

	def busca
		@termo_busca = params[:termo]
		@resultado_busca = Produto.where "nome like ? or descricao like ?", "%#{@termo_busca}%", "%#{@termo_busca}%"
	end

	def create
		valores = params.require(:produto).permit :nome, :preco, :quantidade, :descricao
		@produto = Produto.new valores
		if @produto.save
			redirect_to root_url
		else
			render :new
		end
	end

	def destroy
		id = params[:id]
		Produto.destroy id
		redirect_to root_url
	end

end
