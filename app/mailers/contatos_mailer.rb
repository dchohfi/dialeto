class ContatosMailer < ActionMailer::Base
  default :from => "contato@lledd.com"
  
  def novo_contato(contato)
    @contato = contato
    mail(:to => "dchohfi@gmail.com", :subject => contato.assunto)
  end
end