require 'spec_helper'
describe Video do
  subject{Factory(:video)}
  
  it { should validate_presence_of(:nome) }
  it { should validate_presence_of(:categorias) }
  it { should validate_presence_of(:perfis) }
  it { should validate_presence_of(:images) }
  it { should validate_uniqueness_of(:nome).case_insensitive }
  it { should have_attached_file(:media) }
  it { should validate_attachment_presence(:media) }
  it "deveria conter todos os campos json" do
    Object.pathy!
    
    JSON.parse(subject.to_json).should have_json_path "video"
    JSON.parse(subject.to_json).should have_json_path "video.id"
    JSON.parse(subject.to_json).should have_json_path "video.created_at"
    JSON.parse(subject.to_json).should have_json_path "video.nome"
    JSON.parse(subject.to_json).should have_json_path "video.updated_at"
    JSON.parse(subject.to_json).should have_json_path "video.descricao"
    JSON.parse(subject.to_json).should have_json_path "video.media_content_type"
    JSON.parse(subject.to_json).should have_json_path "video.media_file_size"
    JSON.parse(subject.to_json).should have_json_path "video.media_file_name"
    JSON.parse(subject.to_json).should have_json_path "video.tag_list"
    JSON.parse(subject.to_json).should have_json_path "video.images_url"
    JSON.parse(subject.to_json).should have_json_path "video.authenticated_media_url"
    JSON.parse(subject.to_json).should have_json_path "video.categorias.id"
  end
end