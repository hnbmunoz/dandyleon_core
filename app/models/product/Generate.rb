class Product
  class Generate
    def self.New(details)            
      return "Name already exists" if  Product.find_by("LOWER(name) LIKE ?" ,details["name"].downcase) != nil
      return "Product must have a category" if  Category.where("id = #{details['category_id']}").take == nil
      return "Product Name is required" if details['name'] == "" or  details['name'] == nil     
      new_product = Product.new(details)      
      return new_product.id if (new_product.save)   
    end

    def self.Modification(id, details)  
      return "Product Name is required" if details['name'] == "" or  details['name'] == nil   
      return "Product must have a category" if  Category.where("id = #{details['category_id']}").take == nil            
      return "Name already exists" if Product.where("LOWER(name) LIKE ?" ,details["name"].downcase).where.not(:id => id).take != nil

      Product.find(id).update(details) 
      return "OK"     
    end
  end 
end