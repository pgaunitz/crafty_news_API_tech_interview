RSpec.describe 'POST /api/comments', type: :request do
  let!(:article) { create(:article) }

  describe 'with vslid credentials' do
    let!(:user) { create(:user) }
    let(:user_credentials) { user.create_new_auth_token }
    let(:user_headers) do
      { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials)
    end
    before do
      post '/api/comments',
           params: {
             comment: {
               body: 'comment', user_id: user.id, article_id: article.id
             }
           },
           headers: user_headers
    end

    it 'returns 200 response' do
      expect(response).to have_http_status 200
    end

    it 'return message' do
      expect(response_json['message']).to eq 'Comment posted'
    end

    it 'comment saved' do
      expect(Comment.last.body).to eq 'comment'
    end

    it 'comment saved to correct article' do
      expect(Comment.last.article.id).to eq article.id
    end
  end

  describe 'with vslid credentials' do
    let!(:user) { create(:user) }
    let(:user_credentials) { user.create_new_auth_token }
    let(:user_headers) do
      { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials)
    end
    before do
      post '/api/comments',
           params: {
             comment: {
               body: '', user_id: user.id, article_id: article.id
             }
           },
           headers: user_headers
    end

    it 'returns 200 response' do
      expect(response).to have_http_status 200
    end

    it 'return message' do
      expect(response_json['message']).to eq 'Comment cannot be empty'
    end

    
  end

  describe 'without valid credentials' do
    let!(:user) { create(:user) }
    before do
      post '/api/comments',
           params: {
             comment: {
               body: 'comment', user_id: user.id, article_id: article.id
             }
           },
           headers: headers
    end

    it 'returns 401 response' do
      expect(response).to have_http_status 401
    end

    it 'return message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end
