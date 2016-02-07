require 'spec_helper'
require 'sidekiq'
require 'app/workers/notifications_worker'

RSpec.describe NotificationsWorker do
  let(:vote_email) { double('Email') }
  let(:my_mailer_class) {
    class_double('UserMailer', vote: vote_email).as_stubbed_const
  }

  before do
    subject.mailer_class = my_mailer_class
  end

  it 'delivers the email' do
    expect(vote_email).to receive(:deliver)
    subject.perform('1', 'like')
  end
end
