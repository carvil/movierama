require 'spec_helper'
require 'ohm'
require 'app/models/base_model'
require 'app/models/user'

RSpec.describe User do
  context 'attributes' do
    it 'is possible to assign an email' do
      expect { subject.email = 'me@me.com' }.to change { subject.email }
    end
  end
end
