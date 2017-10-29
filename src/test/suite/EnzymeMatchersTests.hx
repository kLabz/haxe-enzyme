package test.suite;

import buddy.SingleSuite;
import enzyme.Enzyme.shallow;
import react.ReactMacro.jsx;
import test.component.*;
import enzyme.MatchersHelper;

using buddy.Should;
using enzyme.EnzymeMatchers;

class EnzymeMatchersTests extends SingleSuite {
	public function new() {
		describe("Should<ShallowWrapper>", {
			it("should implement beChecked()", {
				var wrapper = shallow(jsx('<$TestForm />'));

				wrapper.find("#click").should.not.beChecked();
				wrapper.find("#checked").should.beChecked();
				wrapper.find("#not").should.not.beChecked();
				wrapper.find("#tertiary").should.not.beChecked();

				wrapper.find(".check").simulate("click");
				wrapper.find("#click").should.beChecked();
			});

			it("should implement beDisabled()", {
				var wrapper = shallow(jsx('<$TestForm />'));

				wrapper.find("#click").should.not.beDisabled();
				wrapper.find(".disable").simulate("click");
				wrapper.find("#click").should.beDisabled();
			});

			it("should implement beEmpty()", {
				var wrapper = shallow(jsx('<$TestForm />'));

				wrapper.find("h1").should.beEmpty();
				wrapper.find("input").should.not.beEmpty();
				wrapper.find("button").should.not.beEmpty();
			});

			it("should implement bePresent()", {
				var wrapper = shallow(jsx('<$TestForm />'));

				wrapper.find("h1").should.not.bePresent();
				wrapper.find("input").should.bePresent();
				wrapper.find("button").should.bePresent();
			});

			it("should implement containReact()", {
				var wrapper = shallow(jsx('<$Foo />'));

				wrapper.should.containReact(jsx('<$Bar foo="foobar" />'));
				wrapper.should.not.containReact(jsx('<$Foo />'));
				wrapper.should.not.containReact(jsx('<$Bar />'));
				wrapper.should.not.containReact(jsx('<$Bar foo="not bar" />'));
			});

			it("should implement haveClassName()", {
				var wrapper = shallow(jsx('<$Bar foo="bar" />'));

				wrapper.should.haveClassName("bar");
				wrapper.should.not.haveClassName("foo");

				wrapper = shallow(jsx('<$Bar foo="foo bar" />'));

				wrapper.should.haveClassName("bar");
				wrapper.should.haveClassName("foo");
				wrapper.should.haveClassName("bar foo");
				wrapper.should.not.haveClassName("foobar");
				wrapper.should.not.haveClassName("bar foo foobar");
			});

			it("should implement haveHtml()", {
				var wrapper = shallow(jsx('<$TestComponent />'));

				var header = wrapper.find("#header");
				header.should.haveHtml("<div id=\"header\"></div>");
				header.should.haveHtml("<div id='header'></div>");
				header.should.not.haveHtml("<p id=\"header\" />");
				header.should.not.haveHtml("<p id=\"header\"></p>");
				header.should.not.haveHtml("<p id='header'></p>");
			});

			it("should implement haveProp()", {
				var wrapper = shallow(jsx('<$Foo />'));

				var bar = wrapper.find(Bar).first();
				bar.should.haveProp("foo");
				bar.should.haveProp("foo", "foo");
				bar.should.not.haveProp("bar");
				bar.should.not.haveProp("foo", "bar");
			});

			it("should implement haveState()", {
				var wrapper = shallow(jsx('<$TestClick />'));

				wrapper.should.haveState("count");
				wrapper.should.haveState("count", 0);
				wrapper.should.not.haveState("clicked");
				wrapper.should.not.haveState("count", 1);

				wrapper.find("button").simulate("click");

				wrapper.should.haveState("count");
				wrapper.should.haveState("count", 1);
				wrapper.should.not.haveState("count", 0);
			});

			it("should implement haveStyle()", {
				var wrapper = shallow(jsx('<$TestComponent />'));

				wrapper.should.haveStyle("display");
				wrapper.should.haveStyle("display", "inline-block");
				wrapper.should.not.haveStyle("opacity");
				wrapper.should.not.haveStyle("display", "block");
			});

			it("should implement haveTagName()", {
				var wrapper = shallow(jsx('<$TestComponent />'));

				var header = wrapper.find("#header");
				header.should.haveTagName("div");
				header.should.not.haveTagName("p");
			});

			it("should implement haveValue()", {
				var wrapper = shallow(jsx('<$TestForm />'));

				wrapper.find("#novalue").should.not.haveValue();
				wrapper.find("#dvalue").should.haveValue(1);
				wrapper.find("#tvalue").should.haveValue(2);

				wrapper.find("#click").should.haveValue(0);
				wrapper.find(".value").simulate("click");
				wrapper.find("#click").should.haveValue(1);
			});

			it("should implement haveText()", {
				var wrapper = shallow(jsx('<$TestComponent title="foo" />'));

				var h1 = wrapper.find("h1");
				h1.should.haveText("foo");
				h1.should.not.haveText("bar");
			});

			it("should implement includeText()", {
				var wrapper = shallow(jsx('<$TestComponent title="foobar" />'));

				var h1 = wrapper.find("h1");
				h1.should.includeText("foo");
				h1.should.includeText("bar");
				h1.should.includeText("foobar");
				h1.should.not.includeText("foobarz");
			});

			it("should implement matchElement()", {
				var wrapper = shallow(jsx('<$TestComponent />'));

				wrapper.find("#header").should.matchElement(jsx('<div id="header" />'));
				wrapper.should.not.matchElement(jsx('<div />'));

				wrapper = shallow(jsx('<$Foo />'));
				wrapper.should.matchElement(jsx('<$Foo />'));
				wrapper.should.not.matchElement(jsx('<$Bar />'));

				var first = wrapper.children().first();
				first.should.matchElement(jsx('<$Bar foo="foo" />'));
				first.should.not.matchElement(jsx('<$Bar foo="bar" />'));
			});

			it("should implement matchSelector()", {
				var wrapper = shallow(jsx('<$TestComponent />'));

				var header = wrapper.find("#header");
				header.should.matchSelector("div");
				header.should.matchSelector("#header");
				header.should.matchSelector("div#header");
				header.should.not.matchSelector("p");

				var p = wrapper.find("p");
				p.should.matchSelector("p");
				p.should.matchSelector(".content");
				p.should.not.matchSelector("#header");
			});

			it("should have a working getSWName() helper", {
				var wrapper = shallow(jsx('<$TestComponent />'));

				MatchersHelper.getSWName(wrapper).should.be("TestComponent");

				wrapper = shallow(jsx('<$Foo />'));

				MatchersHelper.getSWName(wrapper).should.be("Foo");
				MatchersHelper.getSWName(wrapper.find(Bar).first()).should.be("Bar");
				MatchersHelper.getSWName(wrapper.find(Bar)).should.be("[Bar, Bar, Bar]");
			});
		});
	}
}
