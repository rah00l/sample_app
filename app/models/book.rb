class Book < ActiveRecord::Base
  ##### Scema Information #####
  # name => string
  #    price => integer

  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
