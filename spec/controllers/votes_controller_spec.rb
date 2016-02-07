require 'rails_helper'

RSpec.describe VotesController, :type => :controller do
  let!(:user) {
    User.create(name: 'John', email: 'john@doe.com')
  }

  before {
    expect(controller).to receive(:authorize!).and_return(true)
    expect(controller).to receive(:current_user).and_return(user)
  }

  describe "GET create" do
    let(:vote) { :like }
    let!(:movie) {
      Movie.create(
        title: 'Title', description: 'Description', date: Date.today
      )
    }

    it 'calls the notifier service with the movie' do
      expect_any_instance_of(VotingNotifier).to receive(
        :notify).with(vote).once
      get :create, { t: vote.to_s, movie_id: movie.id }
    end
  end

  describe "GET destroy" do
    xit "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end
end
