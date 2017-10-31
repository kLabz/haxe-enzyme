# Changelog

## 0.4.0 (2017-10-31)

* Added matchers from [enzyme-matchers](https://github.com/airbnb/enzyme). See [EnzymeMatchersTests](src/test/suite/EnzymeMatchersTests.hx).
* Extended lifecycle spies to add callbacks to lifecycle methods (see [example usage with `onRender()`](src/test/suite/EnzymeMatchersTests.hx#L202)).

## 0.3.0 (2017-10-06)

* Added react component lifecycle spies, allowing you to track calls on lifecycle methods. See [LifecycleSpyTests](/src/test/suite/LifecycleSpyTests.hx).

## 0.2.0 (2017-10-05)

* Added support for full DOM rendering with [jsdom](https://github.com/tmpvar/jsdom) and static rendering with [cheerio](https://github.com/cheeriojs/cheerio). See [MountAPITests](/src/test/suite/MountAPITests.hx) and [StaticAPITests](/src/test/suite/StaticAPITests.hx).
* Included cheerio extern from [haxe-js-kit](https://github.com/clemos/haxe-js-kit).

## 0.1.0 (2017-09-28)

* Added support for shallow rendering. See [ShallowAPITests](/src/test/suite/ShallowAPITests.hx).
