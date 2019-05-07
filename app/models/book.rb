class Book < ApplicationRecord
  validates_presence_of :name,
                        :publication_year,
                        :pages,
                        :cover_image
                        
end
