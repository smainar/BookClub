class Book < ApplicationRecord
  validates_presence_of :title,
                        :publication_year,
                        :pages,
                        :cover_image

end
