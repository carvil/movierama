require 'spec_helper'
require 'app/services/voting_notifier'

RSpec.describe VotingNotifier do
  subject { described_class.new(movie) }
  let(:my_worker_class) { class_double('NotificationsWorker').as_stubbed_const }

  before do
    subject.notifications_worker_class = my_worker_class
  end

  describe '#notify' do
    let(:vote) { 'like' }

    context 'with a movie without notifications enabled' do
      let(:movie) { double('Movie', notify: false) }

      it 'does not call the worker' do
        expect(my_worker_class).to_not receive(:perform_async)
        subject.notify(vote)
      end
    end

    context 'with a movie with notifications enabled' do
      let(:movie) { double('Movie', notify: true, id: 1) }

      it 'calls the worker' do
        expect(my_worker_class).to receive(:perform_async).with(movie.id, vote)
        subject.notify(vote)
      end
    end
  end
end
