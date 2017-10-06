package test.suite;

import buddy.SingleSuite;
import enzyme.Enzyme.render;
import react.ReactMacro.jsx;
import test.component.*;

using buddy.Should;

class StaticAPITests extends SingleSuite {
	public function new() {
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
