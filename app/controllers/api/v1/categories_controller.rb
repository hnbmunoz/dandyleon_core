module Api
  module V1
    class CategoriesController < ApplicationController
      skip_before_action :verify_authenticity_token

      # GET /api/v1/categories/
      def index
        begin
          all_categories = Category.all
          render(json: { data: all_categories })
        rescue => exception
          head :internal_server_error, { msg: "Problem in the server try again later" }
        end        
      end
  
      # GET /api/v1/categories/:id
      def show
        begin
          categories_by_id = Category.find(params[:id])                   
          render(json: { data: categories_by_id })          
        rescue => exception
          head :internal_server_error, { msg: "Problem in the server try again later" }
        end        
      end

       # GET /api/v1/categories/:id
       def searched
        begin
          category_by_name = Category.find_by(:name => params[:name])               
          render(json: { data: category_by_name })          
        rescue => exception
          head :internal_server_error, { msg: "Problem in the server try again later" }
        end        
      end


      # POST /api/v1/categories/new
      def create
        # begin
          status = Category::Generate.New(category_params)
          if status            
            response.set_header('msg', 'New category saved Complete')               
            render(json: Category.find_by(:name => category_params["name"]))
          else
            head :not_acceptable, { msg: "Saving failed check category name" }
          end
        # rescue => exception
        #   head :internal_server_error, { msg: "Problem in the server try again later" }
        # end        
      end

      #patch /api/v1/categories/:id
      def modify    
        # head :not_acceptable, { msg: "Update failed check details" }
        # begin
          status = Category::Generate.Modification(params[:id], category_params)          
          if status
            head :ok, { msg: "Category updated" }
          else
            head :not_acceptable, { msg: "Update failed check details" }
          end    
        # rescue => exception
        #   head :internal_server_error, { msg: "Problem in the server try again later" }
        # end        
      end

      private

      def category_params
        params.permit(:name, :description, :url)
      end
    end
  end
end