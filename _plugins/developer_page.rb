module Jekyll

  class DeveloperPage < Page
    def initialize(site, base, dir, developer)
      @site = site
      @base = base
      @dir = dir
      @name = developer["name"].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') + '.html'

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'developer.html')
      self.data['developer'] = developer
      self.data['title'] = developer["name"] + " - Dart Developer"
    end
  end

  class DeveloperIndexPage < Page
    def initialize(site, base, dir, developers)
      @site = site
      @base = base
      @dir = dir
      @name = "index.html"

      developers.each do |developer|
        developer["developerSlug"] = developer["name"].downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')  
      end

      developers.sort_by!{ |d| d["name"] }

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'developer-index.html')
      self.data['developers'] = developers
      self.data['title'] = " Dart Developer Index"
    end
  end

  class DeveloperPageGenerator < Generator
    safe true

    def generate(site)
        dir = 'developers'
        site.data["developers"].each do |developer|
          site.pages << DeveloperPage.new(site, site.source, "developers", developer)
        end

        site.pages << DeveloperIndexPage.new(site, site.source, "developers", site.data["developers"])
    end
  end
end