class Review < ApplicationRecord
  validates_presence_of :username,
                        :title,
                        :rating,
                        :text
end
