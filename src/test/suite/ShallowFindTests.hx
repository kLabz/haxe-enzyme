package test.suite;

import buddy.SingleSuite;
import enzyme.Enzyme.configure;
import enzyme.Enzyme.shallow;
import enzyme.adapter.React16Adapter;
import react.ReactMacro.jsx;
import test.component.*;

using buddy.Should;

class ShallowFindTests extends SingleSuite {
	public function new() {
		configure({
			adapter: new React16Adapter()
		});

		describe("Shallow API: .find(selector)", {
			it("should find by css selector", {
				var wrapper = shallow(jsx('
					<$TestComponent />
				'));

				wrapper.find('.content').length.should.be(3);
				wrapper.find('div.content').length.should.be(2);
				wrapper.find('#header').length.should.be(1);
			});

			it("should find by component constructor", {
				var wrapper = shallow(jsx('
					<$Foo />
				'));

				wrapper.find(Bar).length.should.be(3);
			});

			it("should find by component display name", {
				var wrapper = shallow(jsx('
					<$Foo />
				'));

				wrapper.find('Bar').length.should.be(3);
			});

			it("should find by object property selector", {
				var wrapper = shallow(jsx('
					<$Foo />
				'));

				wrapper.find({foo: 'foobar'}).length.should.be(1);
			});
		});
	}
}
