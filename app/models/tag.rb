class Tag < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :books, through: :taggings, source: :taggable, source_type: "Book"
  has_many :products, through: :taggings, source: :taggable, source_type: "Product"
  # has_many :movies, through: :taggings, source: :taggable, source_type: "Movie"

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.search(query)
    if query
      result = where('name LIKE ?', "%#{query}%")
    else
      scoped
    end
    # debugger
    # find_or_create_by(name: query) if result.count == 0 
  end
end
