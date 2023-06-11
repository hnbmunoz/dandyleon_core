module Api
  module V1
    class ProductsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def index
        begin
          all_categories = Product.all
          render(json: { data: all_categories })
        rescue => exception
          head :internal_server_error, { msg: "Problem in the server try again later" }
        end       
      end

      def show 
        begin
          product_by_id = Product.find(params[:id])                   
          render(json: { data: product_by_id })          
        rescue => exception
          head :internal_server_error, { msg: "Problem in the server try again later" }
        end       
      end

      def create
        # begin
          status = Product::Generate.New(product_params)
          if status 
            head :ok, { msg: "New Product saved" }
          else
            head :not_acceptable, { msg: "Saving failed check details" }
          end
        # rescue => exception
        #   head :internal_server_error, { msg: "Problem in the server try again later" }
        # end
      end 

      def modify
      end

      private

      def product_params
        params.permit(:name, :category_id, :description, :url, :price, :discount, :url)
      end
    end
  end
end