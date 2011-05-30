require 'rubygems'
require 'mongo'

module Frebbe
  class << self
    attr_accessor :pres ,:db
   
    def connect(config)
      @db = Mongo::Connection.new(config[:server],config[:port] || 27017).db(config[:db])
      @pres = @db.collection("presentations")
      pres = @pres
    end
    
    def connectUrl()
      uri = URI.parse(ENV['MONGOHQ_URL'])
      conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
      @db = conn.db(uri.path.gsub(/^\//, ''))
      @pres = @db.collection("presentations")
    end
    
    def insert(data)      
      parent = data[:parentId]
      obj = @pres.insert(data)
      if parent != ""
        @pres.update( {"_id" => parent } , { "$addToSet" =>  {"children" => obj }})
      end
      return obj;
    end
    
    def delete(itemId)      
      result = @pres.remove({:_id => itemId})     
     return result
    end
    
    def deleteRecursive(id)
      presentations = @pres.find({:parentId => id }).to_a      
      for presentation in presentations
        if presentation['children'] != nil
          deleteRecursive presentation['_id']  
        end
        delete presentation['_id'] 
      end
      delete id      
    end
    
    def findByParent(search)    
      presentations = @pres.find({:parentId => search }).to_a
     for presentation in presentations
        presentation['createdDate']=presentation['_id'].generation_time
      end
      return presentations
    end 
    
    def findByTag(search)
      presentations = @pres.find({:tags => {"$in" => search} }).to_a
     for presentation in presentations
        presentation['createdDate']=presentation['_id'].generation_time
      end
      return presentations
    end
    
  end
end