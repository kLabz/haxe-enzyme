package test;

import buddy.SingleSuite;
import enzyme.Enzyme.configure;
import enzyme.Enzyme.shallow;
import enzyme.adapter.React16Adapter;
import react.ReactMacro.jsx;
import test.component.*;

using buddy.Should;

class EnzymeTests extends SingleSuite {
	public function new() {
		configure({
			adapter: new React16Adapter()
		});

		describe("Shallow rendering API", {
			it("should render three <Bar /> components", {
				var wrapper = shallow(jsx('
					<$Foo />
				'));

				wrapper.find(Bar).length.should.be(3);
			});

			it("should render three .content elements", {
				var wrapper = shallow(jsx('
					<$TestComponent />
				'));

				wrapper.find(".content").length.should.be(3);
			});

			it("should render title from props", {
				var wrapper = shallow(jsx('
					<$TestComponent title="Test Props" />
				'));

				wrapper.text().should.be("Test Props");
			});

			it("should render children when passed in", {
				var wrapper = shallow(jsx('
					<$TestSimpleContainer>
						<div className="unique" />
					</$TestSimpleContainer>
				'));

				wrapper.find(".unique").length.should.be(1);
			});

			it("should simulate click events", {
				var nbCalls:Int = 0;
				var onClick = function(_) nbCalls++;

				var wrapper = shallow(jsx('
					<$TestClick onClick=$onClick />
				'));

				wrapper.find("button").simulate("click");
				nbCalls.should.be(1);
			});
		});
	}
}
