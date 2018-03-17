package test.suite;

import buddy.SingleSuite;
import jsdom.Jsdom;
import enzyme.Enzyme.mount;
import enzyme.LifecycleSpy;
import enzyme.ReactWrapper;
import react.ReactMacro.jsx;
import test.component.TestClick;

using buddy.Should;

class LifecycleSpyTests extends SingleSuite {
	public function new() {
		JsdomSetup.init();

		describe("Lifecycle Spy", {
			it("should be initialized correctly", {
				var spy = new LifecycleSpy(TestClick);

				spy.render.called.should.be(false);
				spy.componentWillMount.called.should.be(false);
				spy.componentDidMount.called.should.be(false);
				spy.componentWillUnmount.called.should.be(false);
				spy.componentWillReceiveProps.called.should.be(false);
				spy.componentWillUpdate.called.should.be(false);
				spy.componentDidUpdate.called.should.be(false);
				spy.shouldComponentUpdate.called.should.be(false);

				spy.restore();
			});

			it("should follow the react component lifecycle", {
				var spy = new LifecycleSpy(TestClick);
				var onClick = function() {};

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

				spy.restore();
			});

			it("should call injected callbacks", {
				var spy = new LifecycleSpy(TestClick);
				var onClick = function() {};
				var wrapper:ReactWrapper;

				var methodCalls = {
					render: 0,
					onComponentDidMount: 0,
					onComponentDidUpdate: 0,
					onComponentWillMount: 0,
					onComponentWillReceiveProps: 0,
					onComponentWillUnmount: 0,
					onComponentWillUpdate: 0,
					onShouldComponentUpdate: 0
				};

				spy.onRender = function() {
					switch (++methodCalls.render) {
						case 1:
							// Only render, componentWillMount and componentDidMount should be called
							methodCalls.onComponentDidMount.should.be(1);
							methodCalls.onComponentDidUpdate.should.be(0);
							methodCalls.onComponentWillMount.should.be(1);
							methodCalls.onComponentWillReceiveProps.should.be(0);
							methodCalls.onComponentWillUnmount.should.be(0);
							methodCalls.onComponentWillUpdate.should.be(0);
							methodCalls.onShouldComponentUpdate.should.be(0);

							// Simulate click to trigger setState & re-render
							wrapper.find("button").simulate("click");

						case 2:
							methodCalls.onComponentDidMount.should.be(1);
							methodCalls.onComponentDidUpdate.should.be(0);
							methodCalls.onComponentWillMount.should.be(1);
							methodCalls.onComponentWillReceiveProps.should.be(0);
							methodCalls.onComponentWillUnmount.should.be(0);
							methodCalls.onComponentWillUpdate.should.be(1);
							methodCalls.onShouldComponentUpdate.should.be(1);

							// Simulate click to trigger setState & re-render
							wrapper.find("button").simulate("click");

						case 3:
							methodCalls.onComponentWillUpdate.should.be(2);
							methodCalls.onShouldComponentUpdate.should.be(2);
							methodCalls.onComponentDidUpdate.should.be(1);
							spy.restore();

						default:
					}
				};

				spy.onComponentDidMount = function() methodCalls.onComponentDidMount++;
				spy.onComponentDidUpdate = function(_, _) methodCalls.onComponentDidUpdate++;
				spy.onComponentWillMount = function() methodCalls.onComponentWillMount++;
				spy.onComponentWillReceiveProps = function(_) methodCalls.onComponentWillReceiveProps++;
				spy.onComponentWillUnmount = function() methodCalls.onComponentWillUnmount++;
				spy.onComponentWillUpdate = function(_, _) methodCalls.onComponentWillUpdate++;
				spy.onShouldComponentUpdate = function(_, _) methodCalls.onShouldComponentUpdate++;

				// No callback should have been called
				methodCalls.render.should.be(0);
				methodCalls.onComponentDidMount.should.be(0);
				methodCalls.onComponentDidUpdate.should.be(0);
				methodCalls.onComponentWillMount.should.be(0);
				methodCalls.onComponentWillReceiveProps.should.be(0);
				methodCalls.onComponentWillUnmount.should.be(0);
				methodCalls.onComponentWillUpdate.should.be(0);
				methodCalls.onShouldComponentUpdate.should.be(0);

				wrapper = mount(jsx('
					<$TestClick onClick=$onClick />
				'));
			});
		});
	}
}
