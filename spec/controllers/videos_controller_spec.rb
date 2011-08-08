require "spec_helper"

describe VideosController do

  describe "POST :validate_video" do
    it "validates video successfuly" do
      panda_video_id = '1234'
      video = Factory(:video)
      Video.should_receive(:find_by_panda_video_id).with(panda_video_id).and_return(video)
      path_panda = %r|https://api.pandastream.com/v2/videos/1234.json|
      path_encoding = %r|https://api.pandastream.com/v2/videos/1234/encodings.json|
      response_video = "{\"id\":\"1234\",\"path\":\"1234\",\"original_filename\":\"panda.mp4\"}"
      response_encodings = "[{\"id\":\"1234\", \"video_id\":\"1234\", \"extname\":\".mp4\", \"path\":\"1234\",\"file_size\":320}]"
      
      FakeWeb.register_uri(:get, path_panda, :body => response_video)
      FakeWeb.register_uri(:get, path_encoding, :body => response_encodings)
      
      post :validate_video, :event => 'video-encoded', :video_id => '1234'
      
      video.content_type.should == '.mp4'
      video.file_size.should == 320
      video.file_name.should == '1234'
      video.original_file_name == 'panda.mp4'
      video.status.should == 'completed'
      response.status.should == 200
    end
  end
  
  describe "ao salvar um video" do
    before do
      @user = Factory(:user)
      sign_in @user
    end
    
    def criar_video
      categoria = Factory(:categoria)
      perfil = Factory(:perfil)
      attributes = Factory.attributes_for(:video, :categoria_tokens => [categoria.id], :perfil_tokens => [perfil.id], :images_attributes => [Factory.attributes_for(:image)])
      post :create, :video => attributes
    end
    
    it "deve aumentar o contador de videos" do 
      expect {
        criar_video
      }.to change(Video, :count).by(1)
    end
    
    it "deve redirecionar o usuario para a tela de visualizacao" do
      criar_video
      response.should redirect_to(Video.first)
    end
  end
end