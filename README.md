# Haxe Enzyme

A Haxe library offering externs for the [Enzyme](https://github.com/airbnb/enzyme) library.

Enzyme is a JavaScript Testing utility for React that makes it easier to assert, manipulate, and traverse your React Components' output.

## Limitations

Enzyme provides 3 rendering modes:
* **Shallow rendering**, which is useful to constrain yourself to testing a component as a unit, and to ensure that your tests aren't indirectly asserting on behavior of child components.
* **Full DOM rendering**, which is ideal for use cases where you have components that may interact with DOM APIs, or may require the full lifecycle in order to fully test the component (i.e., `componentDidMount` etc.).
* **Static rendering**, which is used to render react components to static HTML and analyze the resulting HTML structure.

**Shallow rendering** externs are available in this library, while Full DOM and static rendering will have to wait for other externs (mainly [Cheerio](http://cheeriojs.github.io/cheerio/)).

Although react adapters externs for versions 13, 14 and 15 are provided, this library currently focuses on Enzyme v3 + React 16 (React 15 should work just as fine).
