require 'spec_helper'
describe Video do
  subject{Factory(:video)}
  
  it { should validate_presence_of(:nome) }
  it { should validate_presence_of(:categorias) }
  it { should validate_presence_of(:perfis) }
  it { should validate_presence_of(:images) }
  it { should validate_presence_of(:panda_video_id) }
  it { should validate_uniqueness_of(:nome).case_insensitive }
  it { should allow_value("pending").for(:status) }
  it { should_not allow_value(nil).for(:status) }
  it { should_not allow_value("qualquer").for(:status) }
  
  it 'status deve ser inicializado com pending' do
    video = Video.new
    video.status.should == 'pending'
  end
  
  it 'deveria retornar nil quando nao estiver validado' do
    subject.authenticated_media_url.should == nil
  end
  
  it 'deve retornar uma url valida do S3' do
    adicionar_campos_ao_video(subject)
    subject.authenticated_media_url.should_not == nil
  end
  
  it "deve conter todos os campos json" do
     Object.pathy!
     
     adicionar_campos_ao_video(subject)
     
     JSON.parse(subject.to_json).should have_json_path "video"
     JSON.parse(subject.to_json).should have_json_path "video.id"
     JSON.parse(subject.to_json).should have_json_path "video.created_at"
     JSON.parse(subject.to_json).should have_json_path "video.nome"
     JSON.parse(subject.to_json).should have_json_path "video.updated_at"
     JSON.parse(subject.to_json).should have_json_path "video.descricao"
     JSON.parse(subject.to_json).should have_json_path "video.content_type"
     JSON.parse(subject.to_json).should have_json_path "video.file_size"
     JSON.parse(subject.to_json).should have_json_path "video.original_file_name"
     JSON.parse(subject.to_json).should have_json_path "video.tag_list"
     JSON.parse(subject.to_json).should have_json_path "video.images_url"
     JSON.parse(subject.to_json).should have_json_path "video.authenticated_media_url"
     JSON.parse(subject.to_json).should have_json_path "video.categorias.id"
   end
   
   it 'deve ter o mesmo tamanho de urls de imagem' do
     subject.images_url.size.should == subject.images.size
   end
   
   it "deve setar o campo de categoria_ids" do
     Factory(:categoria)
     subject.categoria_tokens = "1,2"
     subject.categoria_ids.should =~ [1,2]
   end
   
   it "deve setar o campo perfil_ids" do
     Factory(:perfil)
     subject.perfil_tokens = "1,2"
     subject.perfil_ids.should =~ [1,2]
   end
   
   it "deve encontrar o video do usuario" do
     video = Factory(:video)
     user = Factory(:user, :perfil => video.perfis.first)
     outro_video = Factory(:video, :perfis => [Factory(:perfil)])
     
     videos_do_usuario = Video.videos_do_usuario(user)
     videos_do_usuario.should include(video)
     videos_do_usuario.should_not include(outro_video)
   end
   
   def adicionar_campos_ao_video(video)
     video.content_type = '.mp4'
     video.file_size = 320
     video.file_name = '1234'
     video.status = 'completed'
   end
end