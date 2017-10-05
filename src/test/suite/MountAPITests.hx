package test.suite;

import buddy.SingleSuite;
import jsdom.Jsdom;
import enzyme.Enzyme.configure;
import enzyme.Enzyme.mount;
import enzyme.adapter.React16Adapter;
import react.ReactMacro.jsx;
import test.component.*;

using buddy.Should;

class MountAPITests extends SingleSuite {
	public function new() {
		configure({
			adapter: new React16Adapter()
		});

		JsdomSetup.init();

		describe("Full rendering API", {
			it("should call componentDidMount", {
				var nbCalls:Int = 0;
				var onMount = function() nbCalls++;

				mount(jsx('
					<$TestDidMount onMount=$onMount />
				'));

				nbCalls.should.be(1);
			});

			it("should render three <Bar /> components", {
				var wrapper = mount(jsx('
					<$Foo />
				'));

				wrapper.find(Bar).length.should.be(3);
			});

			it("should render three .content elements", {
				var wrapper = mount(jsx('
					<$TestComponent />
				'));

				wrapper.find(".content").length.should.be(3);
			});

			it("should render title from props", {
				var wrapper = mount(jsx('
					<$TestComponent title="Test Props" />
				'));

				wrapper.text().should.be("Test Props");
			});

			it("should render children when passed in", {
				var wrapper = mount(jsx('
					<$TestSimpleContainer>
						<div className="unique" />
					</$TestSimpleContainer>
				'));

				wrapper.find(".unique").length.should.be(1);
			});

			it("should simulate click events", {
				var nbCalls:Int = 0;
				var onClick = function(_) nbCalls++;

				var wrapper = mount(jsx('
					<$TestClick onClick=$onClick />
				'));

				wrapper.find("button").simulate("click");
				nbCalls.should.be(1);
			});
		});
	}
}
