require 'rails_helper'


RSpec.describe "Authorization", type: :request do 
  describe "Successful sign up " do    
    it 'can register' do
      post "/signUp", params: { 
        fname: "Henri Nicholli",
        mname: "B",
        lname: "Munoz",
        email: "hnbmunoz@gmail.com",
        display_name: "Henri",
        username: "hnbmunoz",
        password: "g3tP4$$W0rd",}
      expect(response).to have_http_status(200)
    end
  end

  describe "Failed sign up " do    
    it 'can register' do
      post "/signUp", params: { 
        fname: "Henri Nicholli",
        mname: "B",
        lname: "Munoz",
        email: "hnbmunoz@gmail.com",
        display_name: "Henri",
        username: "hnbmunoz",
        password: "123",}
      expect(response).to have_http_status(406)
    end
  end

  describe "Successful sign In " do 
    before do
      post '/signUp', params: { 
        fname: "Henri Nicholli",
        mname: "B",
        lname: "Munoz",
        email: "hnbmunoz@gmail.com",
        display_name: "Henri",
        username: "hnbmunoz",
        password: "g3tP4$$W0rd",}
    end
    it 'can login' do
      post "/signIn", params: {
        username: "hnbmunoz",
        password: "g3tP4$$W0rd"}
      expect(response).to have_http_status(200)
    end
  end

  describe "Invalid sign In " do 
    before do
      post '/signUp', params: { 
        fname: "Henri Nicholli",
        mname: "B",
        lname: "Munoz",
        email: "hnbmunoz@gmail.com",
        display_name: "Henri",
        username: "hnbmunoz",
        password: "g3tP4$$W0rd",}
    end
    it 'can login' do
      post "/signIn", params: {
        username: "hnbmunoz",
        password: "g3tP4$$Word"}
      expect(response).to have_http_status(406)
    end
  end

end

