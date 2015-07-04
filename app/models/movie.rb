class Movie < ActiveRecord::Base

  has_many :tags, :through => :taggings
  has_many :taggings, :as => :taggable

  def tag_name
    tags.map(&:name).join(", ")
  end

  def tag_name=(name)
    self.tags.clear
    self.tags << Tag.find_or_create_by(name: name) unless name.blank?
  end
end
