require 'rails_helper'

RSpec.describe MoviesController, :type => :controller do

  describe "GET index" do
    xit "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    xit "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    xit "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end

    context 'with authorization' do
      let(:notify) { false }
      let(:movie_attrs) {
        {
          title: 'title',
          description: 'desc',
          date: '1957-10-02',
          notify: notify
        }
      }

      before {
        expect(controller).to receive(:authorize!).and_return(true)
      }

      it 'redirects to the root path' do
        post :create, movie_attrs
        expect(response).to redirect_to(root_path)
      end

      it 'creates a new movie' do
        expect { post :create, movie_attrs }.to change { Movie.all.count }.by(1)
      end

      context 'the created movie' do
        let(:movie) { Movie.all.first }

        before { post :create, movie_attrs }

        it 'assigns the notify flag' do
          expect(movie.notify).to eq(notify)
        end
      end
    end
  end
end
