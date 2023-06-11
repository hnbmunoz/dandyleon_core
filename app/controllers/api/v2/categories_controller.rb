module Api
  module V2
    class CategoriesController < ApplicationController
      skip_before_action :verify_authenticity_token
      def index
        # return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])

        all_categories = Category.all.order(id: :desc)
        render(json: { data: all_categories })
      end

      def show 
        # return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])
      
        categories_by_id = Category.find(params[:id])                   
        render(json: { data: categories_by_id })  
      end

      def create
        return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])
        
        status = Category::Generate.New(request.headers["token"], category_params)          
        if status.is_a? Integer          
          response.set_header('msg', "Successfully Saved")                         
          render(json: Category.find(status))
        else          
          head :not_acceptable, { msg: status }
        end
      end

      def modify
        return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])
        
        status = Category::Generate.Modification(params[:id], category_params)          
        if status == "OK"
          response.set_header('msg', "Category Modified")                         
          render(json: Category.find(params[:id]))
        else
          if status.trim == "" 
            status = "Failed to Save"
          end
          head :not_acceptable, { msg: status }
        end    
      end

      private

      def category_params
        params.permit(:name, :description, :url)
      end

    end
  end
end