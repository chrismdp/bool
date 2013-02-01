# bool

This is a cross-platform library for parsing boolean arithmetic expressions like `a && b && (!c || !d)` and evaluating them by assigning values to the variables.

Boolean expressions are parsed into an [abstract syntax tree](http://en.wikipedia.org/wiki/Abstract_syntax_tree) (AST) using a 
lexer/parser generated by various Lex/Yacc clones for the various programming languages. This allows grammars to be fairly similar 
across languages.

Evaluation of the boolean expressions is done by traversing the AST with a visitor. (This is obviously overkill for something as 
simple as boolean expressions, keep reading to understand why).

Supported platforms are Ruby, JRuby, Java and JavaScript. The Ruby gem uses a C extension (for speed) and the JRuby gem uses a Java 
extension (also for speed). Support for e.g. Python could be added easily by using the same C code as the Ruby gem. Java programs (or 
any other JVM-based program such as Scala or Clojure) can also use the Java library as-is.

## Why?

The purpose of this library is twofold.

First, it serves as a simple example of how to build a custom interpreted language with a fast lexer/parser that build a 
visitor-traversable AST, and that runs on many different platforms. People who want to build a bigger cross-platform language could 
leverage the structure and build files in this project. A new [Gherkin](https://github.com/cucumber/gherkin) 3.0 project may use this 
project as a template.

Second, this project actually has a use. The Cucumber project may use it to evaluate _tag expressions_ as current Cucumber 
implementations don't have a proper parser for this.

## Building for all platforms

If you're lucky and already have all the needed software installed you can just run

```
make
```

If that fails for you (it probably will the first time), don't worry. See the individual platform-specific READMEs.