class ContatosMailer < ActionMailer::Base
  default :from => "contato@lledd.com"
  
  def novo_contato(contato)
    @contato = contato
    mail(:to => contato.email, :subject => contato.assunto)
  end
end