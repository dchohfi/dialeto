require 'spec_helper'
describe Propaganda do  
  subject {Factory(:propaganda)}
  
  it { should validate_presence_of(:nome) }
  it { should validate_uniqueness_of(:nome).case_insensitive }
  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should have_attached_file(:media) }
  it { should validate_attachment_presence(:media) }
  it { should validate_attachment_content_type(:image).
                    allowing("image/jpeg", "image/png", "image/gif").
                    rejecting('text/plain', 'text/xml') }
  it { should validate_attachment_content_type(:media).
                    allowing("image/jpeg", "image/png", "image/gif").
                    rejecting('text/plain', 'text/xml') }
  
  it "deveria procurar as propagandas sem categoria" do
    propaganda_com_categoria = subject
    propangada_sem_categoria = Factory(:propaganda, :categorias => [])
    
    propangadas_sem_categoria = Propaganda.with_out_categoria
    propangadas_sem_categoria.should include(propangada_sem_categoria)
    propangadas_sem_categoria.should_not include(propaganda_com_categoria)
  end
  
  it "image_url deve ser igual a url da imagem" do
    subject.image_url.should == subject.image.url
  end
  
  it "media_url deve ser igual a url da imagem" do
    subject.media_url.should == subject.media.url
  end
  
  it "deve setar o campo categorias_id" do
    Factory(:categoria)
    subject.categoria_tokens = "1,2"
    subject.categoria_ids.should =~ [1, 2]
  end
  
  it "deveria conter todos os campos json" do
    Object.pathy!
    
    JSON.parse(subject.to_json).should have_json_path "propaganda"
    JSON.parse(subject.to_json).should have_json_path "propaganda.created_at"
    JSON.parse(subject.to_json).should have_json_path "propaganda.image_file_name"
    JSON.parse(subject.to_json).should have_json_path "propaganda.image_file_size"
    JSON.parse(subject.to_json).should have_json_path "propaganda.media_file_size"
    JSON.parse(subject.to_json).should have_json_path "propaganda.image_url"
    JSON.parse(subject.to_json).should have_json_path "propaganda.nome"
    JSON.parse(subject.to_json).should have_json_path "propaganda.updated_at"
    JSON.parse(subject.to_json).should have_json_path "propaganda.image_content_type"
    JSON.parse(subject.to_json).should have_json_path "propaganda.id"
    JSON.parse(subject.to_json).should have_json_path "propaganda.media_content_type"
    JSON.parse(subject.to_json).should have_json_path "propaganda.media_file_name"
    JSON.parse(subject.to_json).should have_json_path "propaganda.media_url"
    JSON.parse(subject.to_json).should_not have_json_path "propaganda.image_updated_at"
    JSON.parse(subject.to_json).should_not have_json_path "propaganda.media_updated_at"
  end
end