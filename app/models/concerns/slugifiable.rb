module Slugifiable
  def slug
    self.name.parameterize
  end

  def self.find_by_slug(slug)
    self.all.find do |artist|
      artist.slug == slug
    end
  end
end