require 'rails_helper'

RSpec.describe Admin::PostsController, type: :controller do
  # this lets us inspect the rendered results
  render_views
  let(:page) { Capybara::Node::Simple.new(response.body) } 
  let(:adminuser) { Fabricate :admin_user } 
  before { sign_in adminuser }
  let(:user) {Fabricate :user}
  let!(:post) { Fabricate :post, user: user }

  let(:valid_attributes) do
    Fabricate.attributes_for :post
  end

  describe "GET index" do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end


    it "should render the expected columns" do
      get :index
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.body)
      expect(page).to have_content(post.published_at)
    end

    let(:filters_sidebar) { page.find('#filters_sidebar_section') }
    it "filter Name exists" do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_first_name_or_last_name_cont"]', text: 'Name')
      expect(filters_sidebar).to have_css('input[name="q[first_name_or_last_name_cont]"]')
    end
=begin
    it "filter Name works" do
      matching_person = Fabricate :person, first_name: 'ABCDEFG'
      non_matching_person = Fabricate :person, first_name: 'HIJKLMN'

      get :index, params: { q: { first_name_or_last_name_cont: 'BCDEF' } }

      expect(assigns(:persons)).to include(matching_person)
      expect(assigns(:persons)).not_to include(non_matching_person)
    end 
=end
  end
    
end