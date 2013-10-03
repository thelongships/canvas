# This is a model which connect to the kthavatars table. 
# This just has to return the list of available avatars from the database, according to the role ( student / teacher)
# Want to return the list of strings, which are the path to the images.
#


class Kthavatar < ActiveRecord::Base
  
  include Context
  include TextHelper
  
  attr_accessible :id, :name, :path, :taken
  
  def self.get_available_avatars()
    #kthavatars = Kthavatar.where(taken: 'f')
    #kthavatars = Kthavatar.find_by_sql(["SELECT name, type, path FROM kthavatars WHERE taken = 'f'"])
    #kthavatars = Kthavatar.all
    kthavatars = Kthavatar.where(taken: 'f').pluck(:path)
  end
  
  def self.update_avatars_taken()
    
  end
  
end
