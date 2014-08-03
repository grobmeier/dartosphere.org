module Jekyll
  class AnswerBlock < Liquid::Block
    def initialize(tag_name, params, tokens)
      super
      @params = params
    end

    def render(context)
    	html = super
    	params = @params

    	params.strip!
      html.strip!

      <<-MARKUP.strip
<div class="i-answer pure-g">
<div class="i-person pure-u-1-12">
<img src="/img/interviews/#{params}" />
</div>
<p class=\"i-answer-text pure-u-11-12\">
#{html} 
</p>
</div>
      MARKUP
    end
  end

  Liquid::Template.register_tag('answer', AnswerBlock)
end