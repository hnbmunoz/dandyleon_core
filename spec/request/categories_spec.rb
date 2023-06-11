require 'rails_helper'

RSpec.describe "Categories", type: :request do 

  describe "Get all Categories" do
    it 'got all categories' do 
      get '/api/v1/categories'
      expect(response).to have_http_status(200)
    end  
  end

  describe "New Category" do    
    it 'creates a new category' do
      post "/api/v1/categories/new", params: { 
        name: "earrings",
        description: "default earrings",
        url: ""
       }
      expect(response).to have_http_status(200)
    end
  end

  describe "New Category Error" do    
    it 'fails to create a new category' do
      post "/api/v1/categories/new", params: { 
        name: "",
        description: "default earrings",
        url: ""
       }
      expect(response).to have_http_status(406)
    end
  end

  describe "Get Specific Categories" do 
    before do
      post '/api/v1/categories/new', params: { 
        name: "earrings",
        description: "default earrings",
        url: ""
       }
    end

    it 'get category by id' do
      category = Category.last
      get "/api/v1/categories/#{category.id}"
      expect(response).to have_http_status(200)
    end
  end

  describe "Modify Specific Category" do 
    before do
      post '/api/v1/categories/new', params: { 
        name: "earrings",
        description: "default earrings",
        url: ""
       }
    end

    it 'Successfully Modified' do
      category = Category.last
      get "/api/v1/categories/#{category.id}" ,params: { 
        name: "",
        description: "Modified",
        url: ""
       }
      expect(response).to have_http_status(200)
    end

    # it 'fails because name is required' do
    #   category = Category.last
    #   get "/api/v1/categories/#{category.id}" ,params: { 
    #     name: "",
    #     description: "Modified",
    #     url: ""
    #    }
    #   expect(response).to have_http_status(406)
    # end
  end

end