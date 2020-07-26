require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  context "GET #index" do 
    it "should success and render to index page" do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end

    it "should array empty" do
      get :index
      expect(assigns(:posts)).to be_empty
    end

    it "should have one post" do
      create(:post)
      get :index
      expect(assigns(:posts)).to_not be_empty
    end
  end

  context "GET #show" do
    let(:post) { create(:post) }
    it "should success and render to edit page" do
      get :show, params: { id: post.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end

    it "where have id" do
      get :show, params: { id: post.id }
      expect(assigns(:post)).to be_a(Post)
      expect(assigns(:post)).to eq(post)
    end 
  end

  context "GET #new" do
    it "should success and render to new page" do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
    
    it "should new post" do
      get :new
      expect(assigns(:post)).to be_a(Post)
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  context "GET #edit" do
    let(:post) { create(:post) }
    it "should success and render to edit page" do
      get :edit, params: { id: post.id }
      expect(response).to render_template(:edit)
      expect(assigns(:post))
    end
  end

  context "POST #create" do
    let!(:params) {
      { title: 'An awesome post', content: 'Small content' }
    }
    it "create a new post" do
      post :create, params: { post: params }
      expect(flash[:notice]).to eq("Post created success")
      # expect(response).to render_template(:show)
      expect(response).to redirect_to(action: :show, id: assigns(:post).id)
    end

    it "not create a new post" do
      params = { title: 'An awesome post'}
      post :create, params: { post: params }
      expect(response).to render_template(:new)
    end
  end

  context "PUT #update" do
    let!(:post) { create(:post) }

    it "should update post info" do
      params = { title: "Update title post" }

      put :update, params: { id: post.id, post: params }
      post.reload

      expect(post.title).to eq(params[:title])
      expect(flash[:notice]).to eq("Post updated success")
      expect(response).to redirect_to(action: :show, id: assigns(:post).id)
    end

    it "should not update post info" do
      params = { title: nil }

      put :update, params: { id: post.id, post: params }

      expect(response).to render_template(:edit)
    end
  end

  context "DELETE #destroy" do
    let!(:post) { create(:post) }
    it "should delete post" do
      delete :destroy, params: { id: post.id }
      expect(flash[:notice]).to eq("Post destroy success")
      expect(response).to redirect_to(action: :index)
    end
  end
end
