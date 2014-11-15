module Jekyll
  class ReleasesBlock < Liquid::Block
    def initialize(tag_name, params, tokens)
      super
      @params = params
    end

    def render(context)
    	html = super
    	params = @params

    	params.strip!
      site = context.registers[:site]

      i = 0

      html = "<ul>"
      site.data["generated"]["releases"].reverse.each do |release|

        html = html + "<li>"
        html = html + "<a href=\"" + release["link"] + "\">"
        html = html + release["package_name"] + ": " + release["package_version"]
        html = html + "</a> - "

        html = html + "<i>"
        html = html + release["author"].join(", ")
        html = html + "</i>"

        html = html + "</li>"

        i = i + 1
        if i >= params.to_i
          break
        end
      end
      html = html + "</ul>"

      html.strip
    end
  end

  Liquid::Template.register_tag('releases', ReleasesBlock)
end