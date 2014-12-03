---
title: 'Interview with Dart engineer Bob Nystrom'
layout: post
author:
    name: 'Dartosphere'
    email: hello@dartosphere.org
    url: 'https://plus.google.com/+DartosphereOrg/posts'
tags:
    - interview
    - dart
    - dartlang
    - opinion
---


{% question dartosphere.jpg %}
Bob Nystrom you are a Google engineer works on the
Dart language. This is an exciting opportunity for a
developer but is also a difficult position to get.
What are your main developing interests?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>I'm interested in a lot of different kinds of software, but one main theme is that I like writing "tools"—programs, libraries, APIs, and architectures that let other people be creative. Before coming to Google, I was a game developer, and I spent much of that time working on game authoring tech. It's really satisfying seeing my work magnify someone else's creativity. For similar reasons, I also really love user interface work—I like seeing people use my stuff.
</p>
<p>In the past six years, I've also realized how enamored I am of programming languages. They have a lot of overlap with tools and user experience (I tend to consider a programming language a user interface to its semantics), but they're also deeply technical and challenging to work on.</p>

<p>I also really really like working in the open. I like being able to talk publicly about my work and share my code with other people. I get a lot of satisfaction out of communicating with people and building a community.
</p>
<p>The Dart project basically scratches all of these itches, and it's full of people that are a ton of fun to work with, so it's basically my dream project.
</p>{% endanswer %}

{% question dartosphere.jpg %}
What do you think are the most important skills for a developer today are?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>I don't tend to think of things as being "important", and I try not to sort stuff into lists. What's been helpful for me is to try to always keep learning and follow my interests. Several years ago, I got interested in programming languages entirely as a hobby, and now here I am working on one full time.
</p>
<p>I've often been surprised to find that even the most obscure things I pick up end up being useful later. For example, the version constraint solver I wrote for pub has a lot in common with pathfinding code that I learned about when writing games.</p>
{% endanswer %}

{% question dartosphere.jpg %}
Do you think it is important for developers to design their own
language, like you did before joining the Dart team?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>Important? No. Tons of fun, absolutely. If you put real effort into designing and implementing a language, you will seriously stretch your coding abilities. You'll end up a stronger programmer in general, and you'll have a much clearer understanding of the semantics of the languages you use and the trade-offs that led to them.</p>
{% endanswer %}

{% question dartosphere.jpg %}
Dart can be used in the browser, but also on the server side.
Considering there is Golang, JavaScript/NodeJS, Python, the upcoming AtScript and a thousand
other fantastic language options, why do you think Dart matters? 
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>I think a lot of developers want to be able to share code across the client and server sides of their application. That's becoming increasingly important now that apps are shifting a lot of the work they do into the client. Where before your client-side was basically just a bit of window dressing, you now often have an entire live MVC architecture in there. But your server also obviously needs to reason about the data model too, so you find yourself really wishing you only had to implement that once.
</p>
<p>Having a server-side story for Dart answers that. Closer to home, it also makes it possible to write useful command-line apps for Dart. This is really helpful for the team since many of our products—the pub package manager, dart2js, dartanalyzer—are command-line apps. If Dart only ran in the browser, we wouldn't be able to write those in Dart.</p>
{% endanswer %}

{% question dartosphere.jpg %}
And what is your favorite feature in Dart?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>If I had to pick one little feature, it's using => to define both lambdas and members on classes. It's really nice and terse and I use it all the time.
</p>
<p>More generally, I really like how Dart balances object-oriented and functional programming. It has a nice lightweight syntax for defining classes and invoking methods, but it also has top-level functions, a suite of higher-order functions, nice lambdas, and solid lexical scope. That lets me use whichever style best fits the different parts of my program. In practice, it means my code tends to be object-oriented structurally, but using lots of functional idioms in its implementation.</p>
{% endanswer %}

{% question dartosphere.jpg %}
Part of your job was and is is to work on Pub, which is a system
to manage your Dart dependencies.
What was the most interesting aspect in designing such a system?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>The most technically interesting part was implementing the version solver. When you have a bunch of dependencies, and then transitive dependencies, some of which are shared, all of which have version constraints on each other, it's pub's job to pick a concrete set of versions to satisfy those constraints. Doing this correctly in all cases is technically NP-complete, which means some dependency graphs can take longer to solve than the lifetime of our solar system. To get around that, we try to use heuristics to avoid bad paths. It doesn't do a perfect job, but it works pretty well. It's also written asynchronously, which makes the code even trickier.
</p>
<p>But what I'm more pleased about is the social aspect of pub. Before it existed, it was really hard for people to share and reuse Dart code. Now, it's super easy to put some code on pub.dartlang.org and have users rely on it. It makes me really happy to know the Dart ecosystem is almost universally using pub to reuse code.</p>
{% endanswer %}

{% question dartosphere.jpg %}
Reading Pub's documentation, it looks like Pub is capable to do more
than just downloading zip files to a specific folder. It's about
managing assets and even can transform Dart code. Can you explain
more about the idea behind and what problem(s) it will solve?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>If you look at other web ecosystems, build steps are a necessary component for most real-world apps. You need to compile your SASS or LESS to CSS. You need to sprite your images. You need to minify your HTML and JavaScript. Often, these get pipelined together — you compile your SASS to CSS then minify that. Of course, users don't want to have to manually invoke a build system every time they touch a file, so they invariably end up with some file-watching system that automatically triggers builds when source files change.
</p>
<p>We wanted a good solution for this—and in particular one that also worked with dart2js. We had another goal that packages should be able to encapsulate their use of build steps. If I make package like bootstrap, you shouldn't care if I developed it internally using SASS or LESS. You should just see the final CSS files generated from those.
</p>
<p>That led us to creating barback and incorporating it into pub itself. When you depend on a package, pub automatically runs any transformers it defines. From your perspective, you can just rely on those outputs as if they were physically there even though they are actually generated on the fly by the build system.</p>
{% endanswer %}

{% question dartosphere.jpg %}
Some people complained about the tons of dependency managers. Each and
every language gets one. I'm talking about Maven, Ivy, Bower, Packagist and so on.
Do you think we will ever have some kind of "global" dependency management system
Or, does it even make sense to have such a thing?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>It's annoying but, no, I don't think we'll ever have one dependency manager to rule them all. You have a bootstrapping problem: before the user can install packages, they have to be able to run the package manager itself. That means any dependencies the package manager has have to be dealt with manually. To minimize the pain of that, you want as few dependencies there as possible. That typically means the package manager is written in its host language. RubyGems is written in Ruby, npm is written in JavaScript, etc.
</p>
<p>Otherwise, a language team would have to tell users, "Sorry, you have to install this other language first before you can use ours."
</p>
<p>Of course, another option is to rely on the operating system's package manager (apt-get, homebrew, etc.), but then you're stuck with an OS. You can't really ignore users of other major operating systems, and you don't want to force every developer releasing a package to release it for every OS's package manager.</p>
{% endanswer %}

{% question dartosphere.jpg %}
You surely have done a lot of research and tested lots of other
dependency management systems. Which ones did you like most and 
was there anything that particularly impressed you?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>Bundler! Pub's approach to version is lifted directly from Bundler. Yehuda Katz and company are super smart, and I really like their approach of separating out constraints (which the user hand-authors) from locked versions (which the tool solves and selects). I have a hypothesis that every programming language either has a dominant package manager that uses Bundler-style lockfiles, or will eventually move to one.
</p>
<p>As an anti-example, pub is designed explicitly differently from npm. npm is a nice piece of technology, and their ecosystem is amazing. But it's approach to transitive dependencies where each child package contains its dependencies (and so on, down the tree) is, I think, not the best way to do things. You can see now that they are struggling with its limitations by adding things like "peer dependencies".
</p>
<p>Constraint solving is hard, but treating shared dependencies as unshared isn't a better solution in my opinion.</p>
{% endanswer %}

{% question dartosphere.jpg %}
Speaking about dependencies: the Dart community already uploaded a lot
of them to the Dart repository. What are the some dependencies that you don't want to
miss in any project?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>Well, I'm terribly biased since I wrote these, but I find path and args to be indispensable for most command-line apps I write. I also use the unittest package all the time, and often scheduled_test, its async testing big brother.</p>
{% endanswer %}

{% question dartosphere.jpg %}
Do you think Dart is a general purpose language already?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>Absolutely.</p>
{% endanswer %}

{% question dartosphere.jpg %}
Are there any special scenarios which are very good or not so good
to be solved using Dart right now?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>At a technical level, Dart is fully mature. The VM is solid and fast, and the tooling story is better than many other languages. Where you might not find it a good fit for you is at the ecosystem level. The set of Dart libraries is still pretty small, and it's harder to find developers who know the language. That's getting better, but growing a language community takes a long time.</p>
{% endanswer %}

{% question dartosphere.jpg %}
When you look into the future of Dart, what are the things you would
like to see changed?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>We've started using async/await and pub (using the async_await transformer) and it makes async code way better. I can't wait until that's fully supported by the VM so we don't need to go through a translation step and the ecosystem can start using it more broadly.</p>
{% endanswer %}

{% question dartosphere.jpg %}
I would assume you prefer Dart over all other languages these days...
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>I'm a language nerd. Expecting me to prefer just one is like asking a gourmand to just eat one meal for the rest of his life. :)</p>
{% endanswer %}

{% question dartosphere.jpg %}
But if you were forced, what language(s) would you work with
if Dart was not an option? And what do you enjoy about them?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>In my free time, lately I've been writing a lot of vanilla C. There's a lot to not like about C, but it feels good in some weird way to work directly with bytes and pointers. They say you don't really understand something until you can teach it to someone else. If you can teach it to your computer by communicating in C, you really understand it.</p>

<p>I wrote a lot of C++ earlier in my career and it's still fun sometimes. You can make libraries in it that are really beautiful to use, even though the implementation of the library itself is often terrifying to look at. Treating the static type system as a tool and trying to build type-safe abstractions is a lot of fun.</p>

<p>The last half of my game dev career was spent mostly in C#. C# is a wonderful language and I don't know if I've ever been as productive in my life as I was pumping out C# code in Visual Studio.</p>
{% endanswer %}

{% question dartosphere.jpg %}
And here is the question I always ask as the last one:
Imagine that I came straight out from university and needed to make
sense out of this multi-flavored technical world...
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>I'm probably not the best person to ask since I never graduated college and the web world was a lot less multi-flavored when I dropped out. :)</p>
{% endanswer %}

{% question dartosphere.jpg %}
It's hard to decide
what to learn first and what I can pass on. Assuming I wanted to work in
a web environment, what would you recommend that I learned first in 
order to get a job?
{% endquestion %}

{% answer bobnystrom.jpg %}
<p>Depends a lot on the person. Everyone learns in a different way. Some people are bottom up, some are top down. Some need structure and order, some like to explore and play. The first thing is to learn how you learn. Once you've figured that out, everything else gets easier.</p>

<p>My personal rule for learning stuff when someone isn't actively forcing me to learn it is to maximize my fun. The biggest risk for me is just losing interest, so I'm pretty ruthless about doing things in a way that's most enjoyable for me even if it's not necessarily the most efficient. If the visual aspect of the web is what gets you excited, start with Photoshop, HTML and CSS and start designing even if you don't intend to end up a designer. 
</p>
<p>Likewise, if you don't like that, write something like an IRC server or a MUD so that you're still learning about networking but don't have to deal with your own programmer art. What matters is that you keep going.</p>
{% endanswer %}


All questions were asked by <a href="http://plus.google.com/102440702937210603575?prsrc=3" rel="author">Christian Grobmeier</a>.

All answers written by <a href="https://plus.google.com/100798142896685420545/posts">Bob Nystrom</a>, who currently works as engineer for Google Dart.