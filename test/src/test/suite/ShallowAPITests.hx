package test.suite;

import buddy.SingleSuite;
import enzyme.Enzyme.shallow;
import react.ReactMacro.jsx;
import test.component.*;

using buddy.Should;
using enzyme.EnzymeMatchers;

class ShallowAPITests extends SingleSuite {
	public function new() {
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
				var onClick = function() nbCalls++;

				var wrapper = shallow(jsx('
					<$TestClick onClick=$onClick />
				'));

				wrapper.find("button").simulate("click");
				nbCalls.should.be(1);
			});

			it("should return a wrapper around the node at a given index", {
				var wrapper = shallow(jsx('
					<$TestComponent title="Test Props" />
				'));

				wrapper.find('div').at(1).is("#header").should.be(true);
				wrapper.find('div').at(2).is(".content").should.be(true);
			});

			it("should return a wrapper around the child at a given index", {
				var wrapper = shallow(jsx('
					<$TestComponent title="Test Props" />
				'));

				wrapper.childAt(1).is("#header").should.be(true);
				wrapper.childAt(2).is(".content").should.be(true);
			});

			it("should return a wrapper around the child nodes", {
				var wrapper = shallow(jsx('
					<$TestComponent title="Test Props" />
				'));

				wrapper.children().length.should.be(5);
			});

			it("should find ancestors", {
				var wrapper = shallow(jsx('
					<div>
						<$TestSimpleContainer>
							<div className="unique">
								<$TestSimpleContainer>
									<div>
										<div id="child" />
									</div>
								</$TestSimpleContainer>
							</div>
						</$TestSimpleContainer>
					</div>
				'));

				var child = wrapper.find("#child");
				var parent1 = child.closest(".unique");
				parent1.length.should.be(1);
				parent1.closest(TestSimpleContainer).length.should.be(1);

				var parent2 = child.closest(TestSimpleContainer);
				parent2.length.should.be(1);
				parent2.parent().is(".unique").should.be(true);
			});
		});
	}
}
