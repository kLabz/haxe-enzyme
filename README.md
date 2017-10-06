# Haxe Enzyme

A Haxe library offering externs for the [Enzyme](https://github.com/airbnb/enzyme) library.

Enzyme is a JavaScript Testing utility for React that makes it easier to assert, manipulate, and traverse your React Components' output.


## Installation

Using haxelib:
```
haxelib install enzyme
```


## Usage

The following examples use the BDD testing library [buddy](https://github.com/ciscoheat/buddy) by [ciscoheat](https://github.com/ciscoheat).

You can install it with haxelib:
```
haxelib install buddy
```

Or you can use any testing library supporting nodejs instead, and adapt these examples.

```haxe
import enzyme.Enzyme.configure;
import enzyme.Enzyme.render;
import enzyme.adapter.React16Adapter;
import react.ReactMacro.jsx;

using buddy.Should;

class StaticAPITests extends buddy.SingleSuite {
	public function new() {
		// We need to use the adapter for the version of React we are using
		// Before being able to use the Enzyme API
		configure({
			adapter: new React16Adapter()
		});

		describe("Static rendering API", {
			it("should render three .content elements", {
				var wrapper = render(jsx('
					<$TestComponent />
				'));

				wrapper.find(".content").length.should.be(3);
			});

			it("should render title from props", {
				var wrapper = render(jsx('
					<$TestComponent title="Test Props" />
				'));

				wrapper.text().should.be("Test Props");
			});

			it("should render children when passed in", {
				var wrapper = render(jsx('
					<$TestSimpleContainer>
						<div className="unique" />
					</$TestSimpleContainer>
				'));

				wrapper.find(".unique").length.should.be(1);
			});
		});
	}
}
```

For a full working example, see [test/](/test/).
These tests will be updated to include all tests from the enzyme API documentation.


## Rendering modes

Enzyme provides 3 rendering modes:

### `Enzyme.shallow(...)`

**Shallow rendering**, which is useful to constrain yourself to testing a component as a unit, and to ensure that your tests aren't indirectly asserting on behavior of child components.

Read the full [API Documentation](https://github.com/airbnb/enzyme/blob/master/docs/api/shallow.md)

See the [buddy test suite](/test/suite/ShallowAPITests.hx)


### `Enzyme.render(...)`

**Static rendering**, which is used to render react components to static HTML and analyze the resulting HTML structure.

Read the full [API Documentation](https://github.com/airbnb/enzyme/blob/master/docs/api/render.md)

See the [buddy test suite](/test/suite/StaticAPITests.hx)


### `Enzyme.mount(...)`

**Full DOM rendering**, which is ideal for use cases where you have components that may interact with DOM APIs, or may require the full lifecycle in order to fully test the component (i.e., `componentDidMount` etc.).

Read the full [API Documentation](https://github.com/airbnb/enzyme/blob/master/docs/api/mount.md)

See the [buddy test suite](/test/suite/MountAPITests.hx)


## Lifecycle spies

In enzyme documentation, [sinonjs](https://github.com/sinonjs/sinon) is used to test react components lifecycle. However, sinonjs does not work really well with haxe (at least I didn't get it to work as I wanted it to).

This lib includes `LifecycleSpy` which allows you to track calls on lifecycle methods (i.e., `componentDidMount`, `componentWillReceiveProps` etc.).

Example usage:

```haxe
it("should follow the react component lifecycle", {
	var spy = new LifecycleSpy(TestClick);
	var onClick = function(_) {};

	var wrapper = mount(jsx('
		<$TestClick onClick=$onClick />
	'));

	// Only render, componentWillMount and componentDidMount should be called
	spy.render.calledOnce.should.be(true);
	spy.componentWillMount.calledOnce.should.be(true);
	spy.componentDidMount.calledOnce.should.be(true);
	spy.componentWillUnmount.called.should.be(false);
	spy.componentWillReceiveProps.called.should.be(false);
	spy.componentWillUpdate.called.should.be(false);
	spy.componentDidUpdate.called.should.be(false);
	spy.shouldComponentUpdate.called.should.be(false);

	// Simulate click to trigger setState & re-render
	wrapper.text().should.be("Clicked 0 times.");
	wrapper.find("button").simulate("click");
	wrapper.text().should.be("Clicked 1 times.");

	spy.render.callCount.should.be(2);
	spy.componentWillUpdate.calledOnce.should.be(true);
	spy.componentDidUpdate.calledOnce.should.be(true);
	spy.shouldComponentUpdate.calledOnce.should.be(true);

	// Unrelated methods should not have been called
	spy.componentWillMount.calledOnce.should.be(true);
	spy.componentDidMount.calledOnce.should.be(true);
	spy.componentWillUnmount.called.should.be(false);
	spy.componentWillReceiveProps.called.should.be(false);

	// Always release the spy when you are done
	spy.restore();
});
```

See the [buddy test suite](/test/suite/LifecycleSpyTests.hx)

## Previous React versions

Although react adapters externs for versions 13, 14 and 15 are provided, this library currently focuses on Enzyme v3 + React 16.

Other adapters should work just as fine but are not tested yet. This should be added in a near future.
