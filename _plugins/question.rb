module Jekyll
  class QuestionBlock < Liquid::Block
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
<div class="i-question pure-g">
<div class="i-person pure-u-1-12">
<img src="/img/interviews/#{params}" />
</div>
<p class=\"i-question-text pure-u-11-12\">
#{html} 
</p>
</div>
      MARKUP

	    end
  end

  Liquid::Template.register_tag('question', QuestionBlock)
end