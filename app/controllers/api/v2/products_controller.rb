module Api
  module V2
    class ProductsController < ApplicationController
      skip_before_action :verify_authenticity_token
      include ActiveStorage::SetCurrent
      def index
        # return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])
      
        all_products = Product.all.order(id: :desc).map {|prod| prod.as_json.merge(image_url: prod.image.url )}
        render(json: { data: all_products })
      end

      def show     
        selected_product = Product.includes(:category).find(params[:id])        
      
        result = {
          id: selected_product.id,
          name: selected_product.name,
          description: selected_product.description,
          category_id: selected_product.category.id,
          category_name: selected_product.category.name,
          price: selected_product.price,
          discount: selected_product.discount,
          image_url: selected_product.image.url 
        }       
        
        render json: result         
      end

      def show_group        
        if params[:id] == "All"
          render(json: { data: Product.all.order(id: :desc).map {|prod| prod.as_json.merge(image_url: prod.image.url )} }) 
        else
          products_by_category = Product.where("category_id = ?", params[:id]).map {|prod| prod.as_json.merge(image_url: prod.image.url )}
          render(json: { data: products_by_category })
        end        
      end

      def create
        return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])
        
        status = Product::Generate.New(product_params)
        if status.is_a? Integer          
          response.set_header('msg', "Successfully Saved")   
          new_product = Product.find(status)          
          render json: new_product.as_json.merge(image_url: new_product.image.url)    
        else          
          head :not_acceptable, { msg: status }
        end
      end 

      def modify
        return head :not_acceptable, { msg: "Please Log in to your account" } if !Helpers.valid_token?(request.headers["token"])
        
        status = Product::Generate.Modification(params[:id], product_params)          
        if status == "OK"
          response.set_header('msg', "Category Modified")                         
          render(json: Product.find(params[:id]))
        else
          if status.trim == "" 
            status = "Failed to Save"
          end
          head :not_acceptable, { msg: status }
        end  
      end

      private

      def product_params
        params.permit(:name, :category_id, :description, :url, :price, :discount, :url, :image)
      end
    end
  end
end