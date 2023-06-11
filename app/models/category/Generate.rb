class Category
  class Generate
    def self.New(token, details)              
      return "Name already exists" if  Category.find_by("LOWER(name) LIKE ?" ,details["name"].downcase) != nil
      return "Category Name is required" if details['name'] == "" or  details['name'] == nil   
      new_category = Category.new(details)     
      return new_category.id if (new_category.save)   
    end

    def self.Modification(id, details)                        
      return "Name already exists" if Category.where("LOWER(name) LIKE ?" ,details["name"].downcase).where.not(:id => id).take != nil
      return "Category Name is required" if details['name'] == "" or  details['name'] == nil 

      Category.find(id).update(details)      
      return "OK"       
    end
  end 
end