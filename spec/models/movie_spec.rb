require 'spec_helper'
require 'app/models/base_model'
require 'app/models/movie'

RSpec.describe Movie do
  context 'attributes' do
    it "is possible to assign a 'notify' flag" do
      expect { subject.notify = true }.to change { subject.notify }.to(true)
    end
  end
end
