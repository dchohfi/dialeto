require 'spec_helper'

describe Image do
  subject { Factory(:image) }
  
  it { should belong_to(:owner) }
  it { should have_attached_file(:image) }
  it { should validate_attachment_presence(:image) }
  it { should validate_attachment_content_type(:image).
                    allowing("image/jpeg", "image/png", "image/gif").
                    rejecting('text/plain', 'text/xml') }
  
  
end