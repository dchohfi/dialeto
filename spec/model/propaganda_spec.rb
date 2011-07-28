require 'spec_helper'
describe Propaganda do  
  subject {Factory(:propaganda)}
  
  it { should validate_presence_of(:nome) }
  it { should validate_presence_of(:categorias) }
  it { should validate_uniqueness_of(:nome).case_insensitive }
  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should have_attached_file(:media) }
  it { should validate_attachment_presence(:media) }
  
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