class ContatosController < ApplicationController
  def new
    @contato = Contato.new
  end

  def create
    @contato = Contato.new(params[:contato])
    if(@contato.valid?)
      ContatosMailer.novo_contato(@contato).deliver
      flash[:notice] = "Email enviado com sucesso!"
      redirect_to new_contato_path
    else
      render :action => 'new'
    end
  end

end