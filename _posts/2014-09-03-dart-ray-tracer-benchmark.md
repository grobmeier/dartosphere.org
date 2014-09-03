---
layout: post
title: Dart ray tracer benchmark (compared to C#)
categories:
- Dart
author:
  name: 'Nino Porcino'
  email: hello@dartosphere.org
  url: 'http://ninoporcino.blogspot.it/2014/08/dart-ray-tracer-benchmark-compared-to-c.html'
tags:
- Dart
- C#
- Programming
type: post
language: en
keywords: Dart, C#, programming, dart ray tracer
---

As an exercise in Dart programming, this morning I've ported 
[this Raytracer demo](https://github.com/nippur72/Saltarelle.RaytracerDemo) from C# to Dart.

![the new 3d test scene](/img/articles/2014/ray-tracer-in-dart/canvas1.png)

You can get it from [Github](https://github.com/nippur72/Dart.RayTracerDemo).

Two years ago, I've used the same raytracer program to compare the performances 
of two C#-to-JavaScript compilers, [JSIL](http://jsil.org/) and [Saltarelle](http://www.saltarelle-compiler.com/) (see my [blogpost](http://ninoporcino.blogspot.it/2012/12/saltarelle-vs-jsil-raytracer-demo.html)).

Now I use the same program to compare C# and [Dart.](http://dartlang.org/)

Speed comparison is a marginal topic here (though it will be curious to see who's 
fastest in rendering the raytraced scene), I am more interested in the overall 
programming experience as this is my first attempt at Dart (apart the classic 
"hello world"). In brief, I have to decide if Dart it's worth embracing, perhaps 
for a future replacement of C#, considering that Microsoft is not pushing it for 
client-side web development (they are investing in [TypeScript](http://www.typescriptlang.org/) instead).

##Porting the raytracer demo

So I download the [64 bit windows version](http://dartlang.org/) of the Dart editor 
decompress in my desktop. The editor doesn't need to be installed, it just runs from 
the directory. Good.

The editor is a stripped version of Eclipse, the same IDE it's used for Java programming. 
For a long term Visual Studio user, it's a rather chaotic, inconsistent and ugly-looking 
IDE, and I have to force myself to get accustomed to it. My locale (italian) apparently 
is not available (as any other locales), so I have to stick to English. Not a good first 
impression. 

While editing the code, the IDE flickers a lot and lags in intellisense/syntax 
highlighting. Sometimes typing "." or "(" does not produce the intellisense dialog 
(don't know why!). And if the source code has too many errors, the whole syntax 
correction is unstable and unreliable, for instance for a while it gave me a clueless 
"int is not a type", making me wonder if I had correctly imported the libraries. 

Anyway at the end I got used to the IDE and learned to cope with its defects.

For the raytracer demo, I started a new project, and copied the .html and .cs files 
from the old C# project. I then renamed to .dart and started to convert it all. The 
whole process, from installing Dart to seeing the raytraced image, took about three 
hours. I was afraid of getting stuck somewhere, but to my luck that didn't happen. 
Fear of the unknown I suppose. 

Knowing very little of Dart, I decided to resort to Google for everything, even for 
the most trivial problem. Dart documentation is scarce, but a trick I've learned is 
that if you "open declaration" of a method, you are taken directly to the source code 
and can see directly the API comments and/or peek around. Sometimes this is quicker 
than goggling. 

A page that helped me a lot is [this comparison](https://www.dartlang.org/docs/synonyms/#theme-html-attributes) between 
languages, for those who already know another mainstream language. It bootstraps 
you in very short time. 

Back to the code. The first thing I do is to remove by find'n'replace all occurrences 
of "public" because in Dart everything is public by default. Good, C# is too verbose 
in this regard. In my code there are also some "private" variables that I rename by 
prefixing them with "_". That's how Dart marks privates. Don't like much this design, 
but I comprehend where it comes from. 

Another easy replace is "extends" in place of ":" for class inheritance.

float data type is not available in Dart so I replace it with double, removing also 
the "f" from numeric constants (like 3.1415f).  It doesn't matter much because even 
in C# floats are mapped to the JavaScript number data type.

Looking at the docs, I find that Double.MaxValue and Double.MinValue are different, 
in Dart they are: double.MAX_FINITE and double.MIN_POSITIVE.

Dart has no namespaces (it has libraries instead), so I completely remove them 
from the code. 

import takes the place of using in Dart, with a little difference. You import files 
instead of namespaces. So for instance if your projects has three .dart files, you 
have to import them where needed. In C#, once the files are added to the project, 
there is no need to declare them, unless they are on a different namespace (in that 
case you use using). Dart approach is more dynamic, and clearly reminds of the 
Javascript approach (and honestly I think that makes sense in the context of a 
dynamic language). 

Overall, I had to import the following libraries:

 * "dart:html" to be able to work with the canvas (the raytraced image)
 * "dart:js" for JavaScript interop (see later)
 * "dart:math" for sqrt() (in place of Math.Sqrt). Math.Floor() is done via double.floor().

To my surprise Dart has no cast (e.g. (double)x), and in a certain sense it's less 
tolerant than C#. For example you can't pass "0" or "1" as a double parameter, but 
you have to be specific by writing "0.0" and "1.0". A bit annoying. Also I had to 
specify the ~/ operator when dividing by an int number, which looks a bit weird. 

Differently from C#, const(s) are necessarily static, while overloading operators 
are not static. It doesn't make a big difference, but now that I think of it, it makes 
more sense, because constants are defined regardless of the object instance, while 
operators do work on instances. 

Two nice Dart features that helped to shorten the code, are constructor initialization 
(now also featured in C# 6.0) and property getter/setter with the  => syntax. 

For example:

	int get ElapsedMilliseconds => getTime() - start_time;  

This syntax is not very intuitive and one needs to get used to it; but reading the 
Dart documentation it seems to be coherent with the approach of having functions as 
first-class citizens (something I really miss in C#).

The code shortens also for abstract classes, once a class is declared abstract there 
is no need to specify "abstract" for methods, nor to write the "override" keyword when 
implementing the member. 

Another nice feature is string interpolation, which is the equivalent of C#'s String.Format. 
DartEditor is able to perform in-string syntax highlight for string interpolation. 
Unexpected, very good.

Parameters by reference: apparently Dart doesn't have an equivalent of the "ref" C# keyword 
(I guess it's the same for "out"). But I discovered in my code the only "ref" usage was 
unnecessary, so I just dropped it. I like Dart's design here, arguments by reference make 
code unreadable. If more than a return parameter is needed, why not returning a structured 
object? (easy in true dynamic languages).

The code conversion became more complex when I had to do JavaScript interop. In this 
regard the C# Saltarelle compiler is more practical because gives you full access to 
JavaScript by the mean of the[InlineCode] attribute. Here C# is totally different from 
Dart: the C# compiler doesn't pretend to live in a proprietary VM, but assumes from the 
start the code is running within the JavaScript VM, so all objects are accessible and 
tricked to be true C# objects (by the mean of [InlineCode] and other attributes like 
[Imported]). Working with inline JavaScript code is similar to going down at the assembler 
level, it can be more efficient but it's no longer C#. But that fits perfectly in the 
strange world of C# run by the browser.

Dart can't do the same because it's meant to run in its separate VM, and has to work the 
regardless whether it's running in a browser or not. So to be able to access JavaScript 
objects in Dart, you have to do interop.

Interop is really tedious to write, to a certain extent it resembles working with Reflection 
in C#. But luckily for me I had just one object to convert. It's called MersenneTwister, 
and it's used for the sole reason of providing the same random numbers across the two 
different implementations. Since the raytraced scene is generated randomly, I want exactly 
the same scene in both C# and Dart so I can compare their execution speeds. In a different 
context I would have used Dart's native Random functions.

That's why I have a custom Random (and DartEditor will warn of the name conflict) and also 
a custom StopWatch, just to be sure time measurements are the same between the two 
implementations. 

I was very happy to see that the interfaces for working with the canvas (CanvasElement, 
CanvasRenderingContext2D and ImageData) are almost identical to C#, so I had to do only 
minor changes.

Now it's finished, the code is completely converted.

I click run, Dartium quickly opens  and the familiar raytraced image is rendered on the 
screen. Cool, I didn't expect it to work at the first attempt!!!

Being to good to be true, I check for caching, fearing that the old C# was called in some 
way. But no, it's really Dart code running and doing ray-tracing! Hurray!

After that, it took me a while and lot of googling to discover how to generate the needed 
JavaScript files. While developing, your program will run in Dartium within the DartVM. 
You can "Manage Launches" and run on generic browsers too, but if you want your JavaScript 
files generated for deploy, you have to click the tool option "Pub Build".

Ok. Done. All is ready. Let's see the benchmark results!

##Results

I tested the program my old AMD Athlon II X4 640 CPU, running @3GHZ with 8GBRAM and 
Windows 7 X64. It's the same machine I used two years ago for the JSIL-vs-Saltarelle test.

Browsers:

 * Firefox: 31.0
 * Chrome: 36.0.19
 * Chromium: 36.0.19
 * Internet Explorer: 11.0.96

The program is set to draw the random scene pictured above, in a 640x480 canvas and 
report the average time per pixel spent in calculation (expressed in milliseconds). 

Since there is a certain variability among different runs, I repeated the test several 
times taking the smallest number (this aint very scientific, I know). Such variability 
is evident in Chrome, where the first run is usually a lot faster. Refreshing the page 
never gives the same fast numbers. Maybe it's because of garbage collector kicking in, 
who knows! 

##Dart Results:

When run in Chromium (aka Dartium) Dart can be executed in native mode because of the 
embedded DartVM. In all other cases, Dart code needs to be transpiled to JavaScript. 

1. Dartium (DartVM) unchecked mode: 0.002,8 ms/pixel
2. Dartium (DartVM)   checked mode: 0.006,3 ms/pixel
3. Chrome   (JavaScript): 0.025,6 ms/pixel
4. Explorer (JavaScript): 0.108,3 ms/pixel (*)
5. Firefox  (JavaScript): 0.112,9 ms/pixel

(*) For some strange reason, Explorer didn't work from outside of the DartEditor, 
giving the exception "unable to bind to a null object". 

##C# Results:

These numbers come from running the C# program (Chrome result is different from the 
two years ago test, due to browser updates). 

 * Firefox:  0.000,3 ms/pixel
 * Chrome:   0.003,6 ms/pixel
 * Explorer: 0.012,6 ms/pixel

##Remarks

First we notice the native Dart VM fulfils the promise of being faster than compiled 
JavaScript. It's a 10x increase between unchecked mode and the fastest JavaScript 
browser. Not bad, but we expected that.

What we didn't expect is the poor performance of DartVM compared to C#. They are on 
the same order of magnitude (Dartium 0.002 ms vs Chrome 0.003 ms), meaning that there 
is no big difference of using transpiled JavaScript or going native with Dart. If that 
holds true, the whole Dart purpose is in danger!

What are the reason of this? Hard to say. For sure Javascript runtimes have benefited 
from browsers war between vendors, while Dart is young and has no competitors. This is 
confirmed if you look at the numbers of the two years ago test: you will notice that, 
on the same machine, Chrome has halved its execution speed, in just two years!

Anyway what is totally disappointing for me is the even worse performance of the compiled 
JavaScript (dart2js). It's ten time slower than the C# counterpart! It is evidently 
slower even without doing any measurement, just by eye. Not only, Dart output is also 
bigger in terms of file size. The file dart_raytracerdemo.dart.js is 360 KB long 
(unminified), while the C# counterpart (mscorlib.js+raytracerdemo.js) is only 139 KB. 
The Dart team has a lot to improve here.

##Conclusion

Overall, it was an interesting experience to port this program from C# to Dart. My 
conclusion is that Dart is a promising language, featuring all that I miss in C#, but 
still too young to go all-in with it. But it's also true that Microsoft failed to 
adopt C# as main web development language, so I would be happy if Dart takes its place 
one day.

##Edit of 23 Aug: Tests repeated

As I've been asked to report data differently and do more accurate measurements, 
I've repeated the whole benchmarks with some changes:

 * I've measured total elapsed time in place of time per pixel; it doesn't change much 
but it easier to understand.
 * The scene was made more complex by having 300 random spheres instead of 30. This 
increases the overall elapsed time roughly by 10x, making the measurements less variable.
 * I've also compiled a "native C#" version of it, in order to compare Dart VM vs Microsoft VM 
(aka CLR or MSIL). 

##Edit of 24 Aug: added TypeScript

[+Freemen Muaddib](https://plus.google.com/u/0/+FreemenMuaddib/about) suggested to 
add a native JavaScript implementation to the benchmark, so this morning I derived 
one by porting the source first to [TypeScript](http://www.typescriptlang.org/) and 
then compiling to JavaScript.

It was an harder work than the Dart port, because in TypeScript type annotations have a 
different (and more clumsy) syntax. Also, no operator overloads (it was an hell to work 
with vector math) and you have always to reference to "this" for class members, even when 
you are within the class itself. In other words, TypeScript inherits all the JavaScript 
quirks.

Anyway Typescript resulted the fastest among all in Chrome. See the updated table of results.

##Edit of 25 Aug: improved Dart code

[+StephanHerhut](https://plus.google.com/+StephanHerhut) suggested to initialize two fields to 0.0, 
because explicit initialization, especially for static fields, helps type inference in Dart. 
This is also semantically consistent with the C# version, because in a certain sense, it 
simulates non-nullability of the fields.
 
This simple fix resulted in a ~50% speed increase for dart2js compiled code and ~10% for 
DartVM. The native execution was also improved with [VyacheslavEgorov's](https://plus.google.com/+VyacheslavEgorov) suggestion 
of using double constants instead of integer constants when doing compare operations (eg. if(r>255.0) in place of if(r>255)). 

See the updated results.

the new 3d test scene:

![the new 3d test scene](/img/articles/2014/ray-tracer-in-dart/canvas1.png)

new results, time is expressed in seconds

![Performance table](/img/articles/2014/ray-tracer-in-dart/table.png)
![Elapsed time](/img/articles/2014/ray-tracer-in-dart/graph.png)

##Final remarks

 * TypeScript is the fastest among all. 
 * Dart VM is the faster than Microsoft VM, it's a surprise.
 * Transpiled C# does a nice job competing both with Dart VM and Microsoft VM. 
 * Dart2Js has a lot to improve

The [Github repo](https://github.com/nippur72/Dart.RayTracerDemo) now contains all the versions used 
for this test: Dart, C# Saltarelle, C# native and TypeScript.

