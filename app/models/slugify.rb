module Slugify
  module InstanceMethods
    def slug
      slug = self.name.downcase.strip.gsub(' ', '-').gsub(/[\W]/, '-')
      slug
    end

  end

  module ClassMethods

    def find_by_slug(slug)
      artist = self.all.detect {|s| s.slug == slug}
      artist
    end

  end

end
