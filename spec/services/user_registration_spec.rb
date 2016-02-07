require 'spec_helper'
require 'active_support/core_ext/time'
require 'app/models/base_model'
require 'app/models/user'
require 'app/services/user_registration'

RSpec.describe UserRegistration do
  subject { described_class.new(auth_hash) }

  describe '#user' do
    let(:user) { subject.user }

    context 'with a new user' do
      let(:email) { 'john@doe.com' }
      let(:name) { 'John' }
      let(:provider) { 'github' }
      let(:uid) { '1' }
      let(:auth_hash) {
        {
          'provider' => provider,
          'uid' => uid,
          'info' => {
            'name' => name,
            'email' => email
          }
        }
      }

      it 'assigns a uid to the user' do
        expect(user.uid).to eq([provider, uid].join('|'))
      end

      it 'assigns the email address to the user' do
        expect(user.email).to eq(email)
      end

      it 'assigns the name to the user' do
        expect(user.name).to eq(name)
      end
    end
  end
end
