module Jekyll

  class CategoryPage < Page
    def initialize(site, base, dir, category_metadata, category_key)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'list.html')
      self.data['category_metadata'] = category_metadata
      self.data['category_key'] = category_key

    end
  end

  class CategoryPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'list'
        dir = site.config['podcast_dir'] || 'podcasts'
        site.data.each do |category_key, category_metadata|
          site.pages << CategoryPage.new(site, site.source, File.join(dir, category_key), category_metadata, category_key)
        end
      end
    end
  end

end