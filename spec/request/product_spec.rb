require 'rails_helper'

RSpec.describe "Products", type: :request do 

  describe "Get all Products" do
    it 'got all products' do 
      get '/api/v1/products'
      expect(response).to have_http_status(200)
    end  
  end

  describe "New Product" do
    before do
      post '/api/v1/categories/new', params: { 
        name: "Test Category",
        description: "default Category",
        url: ""
       }
    end

    it 'creates a new product' do
      category = Category.last
      post "/api/v1/products/new", params: { 
        name: "default product",
        category_id: category.id,
        description: "default description",
        price: 500.00,
        discount: 0.0,
        url: ""
       }
      expect(response).to have_http_status(200)
    end

    # describe 'View product by ID' do

    #   context 'valid parameters' do
    #     it 'works!' do
    #       post "/api/v1/categories/new", params: { 
    #         name: "default category",
    #         description: "default description",
    #         url: ""
    #       }
  
    #       post "/api/v1/products/new", params: { 
    #         name: "default product",
    #         category_id: Category.last.id,
    #         description: "default description",
    #         price: 500.00,
    #         discount: 0.0,
    #         url: ""
    #       }
  
  
    #       get "/api/v1/products/#{Product.last.id}"
    #       expect(response).to have_http_status(201)
    #     end
    #   end
    end
  end

 
  