---
title: 'Getting Started with Dart & React'
layout: post
published: '2017-11-25T23:55:00-04:00'
author:
    name: 'Lee Robinson'
    email: lrobinson2011@gmail.com
    url: 'https://www.leejamesrobinson.com'
tags:
    - dart
    - dartlang
    - react
    - over_react
---

![React + Dart](https://i.imgur.com/ww3HPeP.png)


There are a million different ways to build a web app in today's landscape. Different languages and frameworks come and go and vary in popularity. There isn't one right way to do things and ultimately it's about weighing the pros and cons of the available tools at your disposable. The goal of this article is to inform you about another option you may have not previously considered: using React with Dart.

### Table of Contents

- [What is Dart?](#what-is-dart)
- [Why React?](#why-react)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
- [Building & Running](#building-running)
- [Dart Development Environment](#dart-development-environment)
- [Building the Application](#building-the-application)
- [Testing](#testing)
- [Continuous Integration](#continuous-integration)
- [Deploying](#deploying)
- [Your Turn](#your-turn)
- [Additional Resources](#additional-resources)

### What is Dart?

Dart is a programming language originally [developed by Google](https://www.dartlang.org/) for building complex web applications. It's a statically-typed alternative to JavaScript that compiles to JS for use in the browser. It's open-source, easy to learn, and easy to scale. But wait, there's more!

- Strong IDE integration (code completion, code navigation, static analysis, etc.)
- Strong core set of common libraries (async, collections, isolates, etc.)
- Excellent development ecosystem
- Multi-threading support
- And [much, much more](https://www.dartlang.org/guides/language)

Google uses Dart for [AdWords](https://news.dartlang.org/2016/03/the-new-adwords-ui-uses-dart-we-asked.html) which makes up the majority of Google's revenue. It's also the language we use at [Workiva](https://www.workiva.com/) for our next-generation products. Workiva has committed to using Dart and has published a [variety of OSS (open-source software) libraries](https://workiva.github.io/) to make developer's lives easier. If you're curious, here's a list of some companies [who use Dart.](https://www.dartlang.org/community/who-uses-dart) 

### Why React?

As I mentioned at the start of this article, it's important to thoroughly evaluate all of the different framework options before choosing what's right for your team or company. I won't go too in-depth here on [React](https://reactjs.org/) vs. [Angular](https://angular.io/) since there are a [variety of articles](https://www.google.com/search?q=react+vs+angular) that dive into specifics, but I will note a couple wins for React:

- Uni-directional data flow
- Declarative nature of rendering views
- XML-like syntax called JSX

### Requirements

Let's assume we are given some requirements to create a todo list as shown below. To help us ["think" in React](https://reactjs.org/docs/thinking-in-react.html), I've outlined the design with boxes for each React component.

![Todo List Spec Outlined](https://i.imgur.com/CnOGzML.png)



### Getting Started

The IDE you choose is mostly personal preference, but here are some I suggest for Dart:

- [VS Code](https://code.visualstudio.com/) (Free)
- [WebStorm](https://www.jetbrains.com/webstorm/) (Requires License)

You can clone the git repository with the todo application by running:

```bash
$ git clone https://github.com/leerob/dart-react-todo.git
$ cd dart-react-todo
```

You can install Dart on macOS using Homebrew.

```bash
$ brew tap dart-lang/dart
$ brew install dart --with-content-shell --with-dartium
```

Dartium is a special build of [Chromium](https://en.wikipedia.org/wiki/Chromium_(web_browser)) distributed with the Dart SDK that includes the Dart VM. Using Dartium means you don’t have to compile your code to JavaScript until you’re ready to test on other browsers. This allows for a faster development iteration cycle.

Dartium is going away in Dart 2.0. In Dart 2.0, you’ll use Chrome or other standard browsers for testing instead of Dartium thanks to a new development compiler called [dartdevc](https://webdev.dartlang.org/tools/dartdevc). Rather than go in-depth on Dartium, this tutorial will use Chrome instead in preparation for Dart 2.0. For more information see [Dart 2.0 Updates](https://www.dartlang.org/dart-2.0).

### Building & Running

The Dart SDK comes with a tool called `pub` to help manage your codebase. The most common command `pub get` is used to download a package's dependencies. This is the first thing you will need to do when checking out an
existing Dart repository.

`pub serve` starts up a development server for your Dart application. Refreshing your browser will recompile your Dart files to JavaScript. As previously mentioned, with Dart 2.0 you will be able to "hot reload" with dartdevc. You can download a [pre-release](https://www.dartlang.org/dart-2.0#testing) of Dart 2.0 if you need this now.

To retrieve all of the dependencies for the todo application and start a server, we can run:

```bash
$ pub get
$ pub serve
```
Now, we can open up http://localhost:8080/ to see the todo application.

### Dart Development Environment

The Dart SDK ships with tools to help you hit the ground running instead
of having to set up your own development and build environments for each
project. These tools provide dependency management, code compilation /
minification, and debugging support out of the box.

##### Directory & File Structure

Dart has a prescribed directory structure in order to ensure that its tools work
out of the box.

```
your_app/
├── lib/
│   └── src/
├── test/
├── tool/
├── web/
├── pubspec.lock
└── pubspec.yaml
```

* **`lib/`**
  * Contains all internal implementation code.
* **`test/`**
  * Contains all unit, integration, and functional tests.
* **`tool/`**
  * Contains development tools, scripts, and configuration.
* **`web/`**
  * This directory is served by default when running the application. It is common to
    include an `index.html` file in this directory.
* **`pubspec.yaml`**
  * This file defines all the metadata about your package such as name, version, authors,
  dependencies, etc.
* **`pubspec.lock`**
  * This file specifies the version of each dependency installed in the project. 
  It will be automatically updated when dependencies change in
  `pubspec.yaml` or by running `pub upgrade`.

##### [dart_dev](https://github.com/Workiva/dart_dev)

dart_dev is our centralized tooling built on top of the Dart SDK. All Dart projects eventually share a common set of development requirements:

- Tests (unit, integration, and functional)
- Code coverage
- Consistent code formatting
- Static analysis to detect issues
- Documentation generation

The Dart SDK provides the necessary tooling to accomplish the tasks mentioned above but lacks a consistent usage pattern across multiple projects. Using dart_dev, a single configuration file will get our project configured and ready to use a variety of command line arguments. 

For example: let's analyze and format our entire code base.

```bash
$ pub run dart_dev analyze
$ pub run dart_dev format
```

To make things even more simple, we can set up a bash alias

```bash
$ alias ddev='pub run dart_dev'
```

which turns the previous commands into:

```bash
$ ddev analyze
$ ddev format
```

### Building the Application

Now that we have an understanding of the language/tools we're working with, let's start creating the application! We will be utilizing some of Workiva's OSS. 

##### [OverReact](https://workiva.github.io/over_react/)

OverReact is our library for building statically-typed React UI components. Since OverReact is built on top of React JS, I strongly encourage you to gain familiarity with React first if you're not by reading [this tutorial](https://reactjs.org/docs/hello-world.html). The example below compares a `render()` function for JSX and OverReact that will have the exact same HTML markup result.


* __React JS__ (JSX):

  ```jsx
  render() {
    return <div className="container">
      <h1>Click the button!</h1>
      <button
        id="main_button"
        onClick={_handleClick}
      >Click me</button>
    </div>;
  }
  ```

* __OverReact__ (Dart):

  ```dart
  render() {
    return (Dom.div()..className = 'container')(
      Dom.h1()('Click the button!'),
      (Dom.button()
        ..id = 'main_button'
        ..onClick = _handleClick
      )('Click me')
    );
  }
  ```


Let’s break down the OverReact fluent-style shown above.

```dart
render() {
  // Create a builder for a <div>,
  // add a CSS class name by cascading a typed setter,
  // and invoke the builder with the HTML DOM <h1> and <button> children.
  return (Dom.div()..className = 'container')(

    // Create a builder for an <h1> and invoke it with children.
    // No need for wrapping parentheses, since no props are added.
    Dom.h1()('Click the button!'),

    // Create a builder for a <button>,
    (Dom.button()
      // add a ubiquitous DOM prop exposed on all components,
      // which Dom.button() forwards to its rendered DOM,
      ..id = 'main_button'
      // add another prop,
      ..onClick = _handleClick
    // and finally invoke the builder with children.
    )('Click me')
  );
}
```

OverReact helps bridge the gap between Dart and React. If you're using VS Code, my colleague Jace has created some [OverReact code snippets](https://github.com/JaceHensley/vscode-over-react-snippets) that will help speed up your development. Now, let's talk about our front-end architecture.

##### [w_flux](https://github.com/Workiva/w_flux)

w_flux is our architecture library for Flux - a simple uni-directional data flow pattern that provides an MVC like architecture and works well with React UI components.

![w_flux Diagram](https://i.imgur.com/h3u3tmA.png)

This library was inspired by [RefluxJS](https://github.com/reflux/refluxjs) and Facebook's [Flux](https://facebook.github.io/flux/). The same general principles apply here. For more information, please read the [README](https://github.com/Workiva/w_flux) in the w_flux repository.


##### Defining Dependencies

As previously mentioned, we'll use the `pubspec.yaml` file in our root directory to define the dependencies for our project. Let's take a look at the `pubspec.yaml` for the todo list.

**pubspec.yaml**
```javascript
name: 'todo_dart_react'
version: 1.0.0
description: 'Dart + React Todo List Example'
homepage: 'https://github.com/leerob/dart-react-todo'
author: 'Lee Robinson <lee.robinson@workiva.com>'

environment:
  sdk: '>=1.23.0 <2.0.0'

dependencies:
  w_flux: ^2.9.4
  over_react: ^1.18.1
  react: ^3.6.0

dev_dependencies:
  coverage: ^0.8.0
  test: ^0.12.28
  over_react_test: ^1.3.1
  dart_dev: ^1.8.1
  dart_style: ^1.0.8

transformers:
- over_react
- $dart2js
- test/pub_serve:
    $include: test/**.dart
```

This file tells `pub` which versions of the included packages it needs to retrieve. You can find more information about what all can be included in this file [here](https://www.dartlang.org/tools/pub/pubspec).

##### /web/

Inside the web directory, we'll find the entry point into our application. This file sets up the `Actions` and `Store` for our Flux architecture. Then, it creates a new `TodoApp` component and renders it into our container.

**main.dart**
```dart
import 'dart:html';

import 'package:react/react_dom.dart' as react_dom;
import 'package:react/react_client.dart' as react_client;

import 'package:todo_dart_react/todo_dart_react.dart';

void main() {
  react_client.setClientConfiguration();

  TodoActions actions = new TodoActions();
  TodoStore store = new TodoStore(actions);

  var todoApp = (TodoApp()
    ..actions = actions
    ..store = store)();

  final container = querySelector('#app-container');
  react_dom.render(todoApp, container);
}
```

The container previously mentioned is the `app-container` DOM node shown below. You'll notice I've included [Bootstrap](https://getbootstrap.com/) to handle the styling our of UI components.

**index.html**
```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    
    <title>Dart React Todo</title>
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
  </head>
  <body>
    <div id="app-container" class="container"></div>

    <script src="./packages/react/react.js"></script>
    <script src="./packages/react/react_dom.js"></script>
    <script src="main.dart" type="application/dart"></script>
    <script src="./packages/browser/dart.js"></script>
  </body>
</html>
```


##### /lib/src/

Let's take a look at `actions.dart`. This file defines the available operations we can perform.

**actions.dart**
```dart
class TodoActions {
  final Action<Todo> addTodo = new Action<Todo>();
  final Action<Todo> deleteTodo = new Action<Todo>();
  final Action<Todo> completeTodo = new Action<Todo>();
  final Action clearTodoList = new Action();
}
```

You'll notice some actions take a `Todo` parameter. Let's define the structure of our `Todo` model.

**todo.dart**
```dart
class Todo {
  String content;
  bool completed = false;

  Todo(this.content);
}
```

Each `Todo` object can be initialized with some content and has a completed state which is initially `false`.

##### /stores/

We now have some actions to dispatch. Next, we need a store to contain our application's data. For this example, we only need one store. 

**Note**: For larger applications, you will generally have multiple stores. Review the w_flux [README](https://github.com/Workiva/w_flux) for more information.

**todo_store.dart**
```dart
class TodoStore extends Store {
  TodoStore(TodoActions actions) : _actions = actions {
    _todos = [
      new Todo('Learn Dart'),
      new Todo('Learn React'),
      new Todo('????'),
      new Todo('Profit!')
    ];

    triggerOnAction(_actions.addTodo, (todo) => _todos.add(todo));
    triggerOnAction(_actions.completeTodo, (todo) => todo.completed = true);
    triggerOnAction(_actions.deleteTodo, (todo) => _todos.remove(todo));
    triggerOnAction(_actions.clearTodoList, (_) => _todos = []);
  }

  final TodoActions _actions;

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;
}
```

When our `TodoStore` is constructed, it populates our todo list with some pre-defined `Todo` objects. It also connects our actions to the store using `triggerOnAction()`. This function will re-render all components that are watching the store after the action has completed. You'll also notice we have a public getter to obtain the list of todos. 

To summarize so far, we have:

- Initialized an entry point into the application
- Defined actions for the todo list
- Created a data model for a Todo item
- Set up a store to contain the application's data

##### /views/

The final piece will be the OverReact UI components to display the store's data. We defined a top-level `TodoApp` component in `main.dart`. This is what we refer to as a ["container"](https://medium.com/@dan_abramov/smart-and-dumb-components-7ca2f9a7c7d0) component. It subscribes to our store and dispatches actions. It does *not* handle displaying UI components. 

**todo_app.dart**
```dart
@Factory()
UiFactory<TodoAppProps> TodoApp;

@Props()
class TodoAppProps extends FluxUiProps<TodoActions, TodoStore> {}

@Component()
class TodoAppComponent extends FluxUiComponent<TodoAppProps> {
  @override
  render() {
    return (TodoList()
      ..addTodo = props.actions.addTodo
      ..deleteTodo = props.actions.deleteTodo
      ..todos = props.store.todos)();
  }
}
```

**Note:** If the structure of this component is confusing, please review the [anatomy of an OverReact component.](https://github.com/Workiva/over_react#anatomy-of-an-overreact-component)

The `TodoList` component is a "presentational" component. It has no knowledge of any stores/actions and simply renders the data passed along as props and uses [callbacks](https://redux.js.org/docs/basics/UsageWithReact.html#presentational-and-container-components) to communicate with the store. Let's take a look at the `renderListItems()` function of the `TodoList` component.

**todo_list.dart**
```dart
/// Create a new [TodoListItem] for each todo.
List _renderListItems() {
  List items = [];

  for (Todo todo in props.todos) {
    items.add(
      (TodoListItem()
        ..key = todo.content
        ..todo = todo
        ..deleteTodo = props.deleteTodo)(),
    );
  }

  return items;
}
```

Based on the todo data passed in as props, this function creates a new list of `TodoListItem` components to be rendered. Those components will render as follows:

**todo_list_item.dart**
```dart
render() {
  return ListGroupItem()(
    (Dom.input()
      ..className = 'mr-3'
      ..type = 'checkbox')(),
    Dom.span()(
      props.todo.content,
    ),
    (Button()
      ..addTestId('deleteTodo')
      ..className = 'float-right'
      ..skin = ButtonSkin.DANGER
      ..onClick = ((event) => props.deleteTodo(props.todo)))(
      'Delete',
    ),
  );
}
```

The `ListGroupItem` component is taken from the [OverReact examples](https://workiva.github.io/over_react/demos/). It models the [list group component](https://v4-alpha.getbootstrap.com/components/list-group/) from Bootstrap. You can find more OverReact example components located in `lib/src/components`. You'll notice we've added a test ID to the `Button` component using `..addTestId()`. Let's talk about how we can unit test this component.

### Testing

All of the test files are located in the `test/` directory. For this example, I've only created unit tests. You could also create integration and functional tests here as well. Testing OverReact components is simple using [over_react_test](https://github.com/Workiva/over_react_test) along with the [React test utilities](https://github.com/cleandart/react-dart#testing-using-react-test-utilities). Let's look at how we can test our `TodoListItem` component to check it properly calls `deleteTodo` when the button is clicked.

**todo_list_item_test.dart**
```dart
test('calls deleteTodo when button is clicked', () {
  bool called = false;
  Todo todo = new Todo('Testing!');
  handler(DeleteTodoCallback) => called = true;

  var renderedInstance = render(TodoListItem()
    ..deleteTodo = handler
    ..todo = todo);
      
  Element deleteButton = getComponentRootDomByTestId(renderedInstance, 'deleteTodo');
  click(deleteButton);
  expect(called, isTrue);
});
```

This test creates a new handler for deleting a todo and passes it to the `TodoListItem` when rendering. Then, we can retrieve the delete button from the DOM of the rendered instance and simulate clicking the button. Finally, we can expect that the handler was successfully called.

**Note:** We don't need to test what happens *when* a todo is deleted here. For [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns), we should unit test that it is successfully removed from the store in `todo_store_test.dart`. 

We can now run all unit tests using the following command:

```bash
$ ddev test
```

We can also run a specific test group using the -n flag and providing the group name.

```bash
$ ddev test -n "TodoListItem"
```

### Continuous Integration

Continuous Integration (CI) is the process of automating the building and testing of your code every time you commit changes to GitHub. We can utilize [Travis CI](https://travis-ci.org/) to easily perform static analysis, check formatting, run unit tests, and generate code coverage using a `.travis.yml` file. You don't need to worry about configuring this file - it's already all set up and running in the repository. If you [fork the repo](https://github.com/leerob/dart-react-todo#fork-destination-box) to create your own application, you will need to sync Travis CI and [codecov](https://codecov.io/) with your GitHub account to trigger builds when you commit changes and generate coverage.

### Deploying

When you're ready to compile your code to JS, we can use `pub build`. This command uses
`dart2js` to compile Dart to a single JS bundle. `dart2js` will automatically
remove any dead code or unused libraries. By default, the
compiled code is output to the `build/` directory.

```bash
$ pub build
```

The `build` command has two modes, `release` and `debug`. It defaults to
`release`, which will minify the resulting JS and omit the `.dart` files from
the output directory. In `debug` mode, the output will be un-minified and will
contain `.dart` source files next to compiled code for use with source maps.
This is useful for staging environments where debugging may be required.

```bash
$ pub build --mode debug
```

##### Netlify

[Netlify](https://www.netlify.com) makes it extremely easy to deploy your compiled code. You can create an account for free and have the ability to upgrade to utilize features like custom domain names, SSL, and more. Let's look at how we can deploy our todo application from the command line. 

**Note**: This will create a `.netlify` file which you might want to commit for your application.


```bash
$ npm install netlify-cli -g
$ pub build
$ netlify deploy
? No site id specified, create a new site Yes
? Path to deploy? (current dir) build/web/
Deploying folder: build/web/

Deploy is live (permalink):
  http://5a11de44a6188f59f422296f.goofy-colden-2480f1.netlify.com

Last build is always accessible on http://goofy-colden-2480f1.netlify.com
```

That's it! 🎉 We can modify the settings for our site on Netlify to change the site name. You can view the deployed todo app at https://dart-react-todo.netlify.com/.

### Your Turn

The todo list isn't fully completed per our requirements. To fully finish the application, you'll need to:

- Mark todos as completed when the checkbox is clicked
- Add an action for clearing all completed todos 
- Modify the `TodoStore` to listen to the new action
- Create the `TodoFooter` component
- Hook up the buttons in the footer to the store
- Use icons inside the buttons

You can view the entire source code [here](https://github.com/leerob/dart-react-todo). Thanks for reading!

### Additional Resources

- [Getting the most out of React in Dart](https://www.youtube.com/watch?v=ekBD-_jRjds)
- [Intro to Dart for Java Developers](https://codelabs.developers.google.com/codelabs/from-java-to-dart/index.html#0)
- [Language Tour](https://www.dartlang.org/guides/language/language-tour)
- [Library Tour](https://www.dartlang.org/guides/libraries/library-tour)
- [Effective Dart](https://www.dartlang.org/guides/language/effective-dart)
- [Futures Tutorial](https://www.dartlang.org/tutorials/language/futures)
- [Streams Tutorial](https://www.dartlang.org/tutorials/language/streams)
- [Dart by Example](http://jpryan.me/dartbyexample/)
