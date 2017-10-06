package test.suite;

import buddy.SingleSuite;
import jsdom.Jsdom;
import enzyme.Enzyme.mount;
import enzyme.LifecycleSpy;
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

				spy.restore();
			});
		});
	}
}
