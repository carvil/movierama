require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:email) { ActionMailer::Base.deliveries.first }

  describe '.vote' do
    let!(:user) {
      User.create(name: 'John', email: 'john@doe.com')
    }
    let!(:movie) {
      Movie.create(
        title: 'Title', description: 'Description', date: Date.today, user: user
      )
    }
    let(:vote) { 'like' }

    before do
      described_class.vote(movie.id, vote).deliver
    end

    it 'delivers one email' do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it 'delivers the email to the user of the movie' do
      expect(email.to).to include(user.email)
    end

    it 'includes the movie title in the subject line' do
      expect(email.subject).to include(movie.title)
    end

    it 'includes the vote in the body of the email' do
      expect(email.body.raw_source).to include(vote)
    end
  end
end
