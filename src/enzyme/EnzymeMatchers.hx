package enzyme;

import haxe.PosInfos;
import buddy.Should;
import react.ReactComponent;
import enzyme.MatchersHelper.*;

#if redux
import redux.Redux.Action;
#end

class ShouldShallow extends Should<ShallowWrapper> {
	static public function should(wrapper:ShallowWrapper) {
		return new ShouldShallow(wrapper);
	}

	public function new(value:ShallowWrapper, inverse = false) {
		super(value, inverse);
	}

	public var not(get, never):ShouldShallow;
	private function get_not() { return new ShouldShallow(value, !inverse); }

	private function wasNull(msg:String, ?p:PosInfos) {
		return fail(
			'Expected ShallowWrapper $msg but was null',
			'Expected ShallowWrapper not $msg but was null',
			p
		);
	}

	private function wasEmpty(msg:String, ?p:PosInfos) {
		return fail(
			'Expected ShallowWrapper $msg but was empty',
			'Expected ShallowWrapper not $msg but was empty',
			p
		);
	}

	public function beChecked(?p:PosInfos) {
		if (value == null) return wasNull("to be checked", p);
		if (value.length == 0) return wasEmpty("to be checked", p);

		var pass = false;
		var props = value.props();

		if (props.hasOwnProperty("defaultChecked"))
			pass = props.defaultChecked || false;

		if (props.hasOwnProperty("checked"))
			pass = props.checked;

		test(
			pass,
			p,
			'Expected ${getSWName(value)} to be checked',
			'Expected ${getSWName(value)} not to be checked'
		);
	}

	public function beDisabled(?p:PosInfos) {
		if (value == null) return wasNull("to be disabled", p);
		if (value.length == 0) return wasEmpty("to be disabled", p);

		test(
			!!value.props().disabled,
			p,
			'Expected ${getSWName(value)} to be disabled',
			'Expected ${getSWName(value)} not to be disabled'
		);
	}

	public function beEmpty(?p:PosInfos) {
		if (value == null) return wasNull("to be empty", p);

		test(
			value.length == 0,
			p,
			'Expected ${getSWName(value)} to be empty',
			'Expected ${getSWName(value)} not to be empty'
		);
	}

	public function bePresent(?p:PosInfos) {
		if (value == null) return wasNull("to be present", p);

		test(
			value.length > 0,
			p,
			'Expected ${getSWName(value)} to be present',
			'Expected ${getSWName(value)} not to be present'
		);
	}

	public function containReact(reactInstance:ReactElement, ?p:PosInfos) {
		if (value == null && reactInstance == null) {
			return fail(
				"Expected ShallowWrapper to contain ReactElement but both were null",
				"Expected ShallowWrapper not to contain ReactElement but both were null",
				p
			);
		}

		if (reactInstance == null) {
			return fail(
				'Expected ${getSWName(value)} to contain ReactElement but ReactElement was null',
				'Expected ${getSWName(value)} not to contain ReactElement but ReactElement was null',
				p
			);
		}

		if (value == null) return wasNull('to contain ${getREName(reactInstance)}', p);
		if (value.length == 0) return wasEmpty('to contain ${getREName(reactInstance)}', p);

		test(
			value.contains(reactInstance),
			p,
			'Expected ${getSWName(value)} to contain ${getREName(reactInstance)}',
			'Expected ${getSWName(value)} not to contain ${getREName(reactInstance)}'
		);
	}

	public function haveClassName(className:String, ?p:PosInfos) {
		if (value == null) return wasNull('to have className "$className"', p);
		if (value.length == 0) return wasEmpty('to have className "$className"', p);

		var actualClassName = "(none)";
		var normalizedClassName = className.split(" ").join(".");

		if (!StringTools.startsWith(normalizedClassName, ".")) {
			normalizedClassName = '.$normalizedClassName';
		}

		var pass = switch (value.getElements().length) {
			case 0: false;
			case 1:
				actualClassName = value.prop("className");
				value.is(normalizedClassName);

			default:
				value.reduce(function(allMatch, node, _) {
					if (!node.is(normalizedClassName)) {
						actualClassName = node.prop("className");
						return false;
					}

					return allMatch;
				}, true);
			false;
		};

		test(
			pass,
			p,
			'Expected ${getSWName(value)}\'s className to be "$className", but was "$actualClassName"',
			'Expected ${getSWName(value)}\'s className not to be "$className"'
		);
	}

	public function haveHtml(html:String, ?p:PosInfos) {
		if (value == null) return wasNull('to have be "$html"', p);
		if (value.length == 0) return wasEmpty('to have be "$html"', p);

		var wrapperHTML = value.html();
		var useSingleQuotes = html.indexOf("'") != -1;

		var actualHTML = ~/("|')/g.replace(wrapperHTML, useSingleQuotes ? "'" : '"');
		var expectedHTML = ~/("|')/g.replace(html, useSingleQuotes ? "'" : '"');

		test(
			actualHTML == expectedHTML,
			p,
			'Expected ${getSWName(value)}\'s html to be "$expectedHTML", but was "$actualHTML"',
			'Expected ${getSWName(value)}\'s html not to be "$expectedHTML"'
		);
	}

	public function haveProp(propKey:String, ?propValue:Dynamic, ?p:PosInfos) {
		var withValue = propValue == null ? '' : ' with value "$propValue"';
		if (value == null) return wasNull('to have prop "$propKey"$withValue', p);
		if (value.length == 0) return wasEmpty('to have prop "$propKey"$withValue', p);

		var props = value.props();

		if (!props.hasOwnProperty(propKey)) {
			test(
				false,
				p,
				'Expected ${getSWName(value)} to have prop "$propKey" but it did not',
				'Expected ${getSWName(value)} not to have prop "$propKey"'
			);
		} else if (propValue == null) {
			test(
				true,
				p,
				'Expected ${getSWName(value)} to have prop "$propKey"',
				'Expected ${getSWName(value)} not to have prop "$propKey", but id did'
			);
		} else {
			var actualValue = Reflect.field(props, propKey);

			test(
				propValue == actualValue || shallowCompare(propValue, actualValue),
				p,
				'Expected ${getSWName(value)} to have prop "$propKey" with value "$propValue" but was "$actualValue"',
				'Expected ${getSWName(value)} not to have prop "$propKey" with value "$propValue"'
			);
		}
	}

	public function haveState(stateKey:String, ?stateValue:Dynamic, ?p:PosInfos) {
		var withValue = stateValue == null ? '' : ' with value "$stateValue"';
		if (value == null) return wasNull('to have state "$stateKey"$withValue', p);
		if (value.length == 0) return wasEmpty('to have state "$stateKey"$withValue', p);

		var state = value.state();

		if (!state.hasOwnProperty(stateKey)) {
			test(
				false,
				p,
				'Expected ${getSWName(value)} to have state "$stateKey" but it did not',
				'Expected ${getSWName(value)} not to have state "$stateKey"'
			);
		} else if (stateValue == null) {
			test(
				true,
				p,
				'Expected ${getSWName(value)} to have state "$stateKey"',
				'Expected ${getSWName(value)} not to have state "$stateKey", but id did'
			);
		} else {
			var actualValue = Reflect.field(state, stateKey);

			test(
				stateValue == actualValue || shallowCompare(stateValue, actualValue),
				p,
				'Expected ${getSWName(value)} to have state "$stateKey" with value "$stateValue" but was "$actualValue"',
				'Expected ${getSWName(value)} not to have state "$stateKey" with value "$stateValue"'
			);
		}
	}

	public function haveStyle(styleKey:String, ?styleValue:Dynamic, ?p:PosInfos) {
		var withValue = styleValue == null ? '' : ' with value "$styleValue"';
		if (value == null) return wasNull('to have style "$styleKey"$withValue', p);
		if (value.length == 0) return wasEmpty('to have style "$styleKey"$withValue', p);

		var style = value.prop('style');

		if (style == null || !style.hasOwnProperty(styleKey)) {
			test(
				false,
				p,
				'Expected ${getSWName(value)} to have style "$styleKey" but it did not',
				'Expected ${getSWName(value)} not to have style "$styleKey"'
			);
		} else if (styleValue == null) {
			test(
				true,
				p,
				'Expected ${getSWName(value)} to have style "$styleKey"',
				'Expected ${getSWName(value)} not to have style "$styleKey", but id did'
			);
		} else {
			var actualValue = Reflect.field(style, styleKey);

			test(
				styleValue == actualValue || shallowCompare(styleValue, actualValue),
				p,
				'Expected ${getSWName(value)} to have style "$styleKey" with value "$styleValue" but was "$actualValue"',
				'Expected ${getSWName(value)} not to have style "$styleKey" with value "$styleValue"'
			);
		}
	}

	public function haveTagName(tagName:String, ?p:PosInfos) {
		if (value == null) return wasNull('to have tag "$tagName"', p);
		if (value.length == 0) return wasEmpty('to have tag "$tagName"', p);

		var actualTag = value.name();

		test(
			actualTag == tagName,
			p,
			'Expected ShallowWrapper to have tag "$tagName" but had tag "$actualTag"',
			'Expected ShallowWrapper not to have tag "$tagName"'
		);
	}

	public function haveValue(?expectedValue:Dynamic, ?p:PosInfos) {
		if (value == null) return wasNull('to have value "$expectedValue"', p);
		if (value.length == 0) return wasEmpty('to have value "$expectedValue"', p);

		var props = value.props();
		var actualValue = null;

		if (props.hasOwnProperty("defaultValue"))
			actualValue = props.defaultValue;

		if (props.hasOwnProperty("value"))
			actualValue = props.value;

		test(
			(actualValue == expectedValue) && (!inverse || expectedValue != null),
			p,
			'Expected ${getSWName(value)} to have value "$expectedValue"',
			'Expected ${getSWName(value)} not to have value "$expectedValue"'
		);
	}

	public function haveText(text:String, ?p:PosInfos) {
		if (value == null) return wasNull('to have text "$text"', p);
		if (value.length == 0) return wasEmpty('to have text "$text"', p);

		var actualText = value.text();
		var pass = (text == null && actualText.length > 0) || (actualText == text);

		test(
			pass,
			p,
			'Expected ShallowWrapper to have text "$text" but had text "$actualText"',
			'Expected ShallowWrapper not to have text "$text"'
		);
	}

	public function includeText(text:String, ?p:PosInfos) {
		if (value == null) return wasNull('to include text "$text"', p);
		if (value.length == 0) return wasEmpty('to include text "$text"', p);

		if (text == null) {
			var message = 'Expected ".includeText(null)" to be given some text.
				If you are trying to assert this component has _some_ text, use the ".haveText()" matcher';

			return fail(message, message, p);
		}

		var actualText = value.text();

		test(
			actualText.indexOf(text) > -1,
			p,
			'Expected ShallowWrapper to include text "$text" but had text "$actualText"',
			'Expected ShallowWrapper not to include text "$text"'
		);
	}

	public function matchElement(reactInstance:ReactElement, ?p:PosInfos) {
		if (value == null && reactInstance == null) {
			return fail(
				"Expected ShallowWrapper to match ReactElement but both were null",
				"Expected ShallowWrapper not to match ReactElement but both were null",
				p
			);
		}

		if (reactInstance == null) {
			return fail(
				'Expected ${getSWName(value)} to match ReactElement but ReactElement was null',
				'Expected ${getSWName(value)} not to match ReactElement but ReactElement was null',
				p
			);
		}

		if (value == null) return wasNull('to match ${getREName(reactInstance)}', p);
		if (value.length == 0) return wasEmpty('to match ${getREName(reactInstance)}', p);

		var expectedWrapper = Enzyme.shallow(reactInstance);

		test(
			value.shallow().debug() == expectedWrapper.debug(),
			p,
			'Expected ${getSWName(value)} to match ${getREName(reactInstance)}',
			'Expected ${getSWName(value)} not to match ${getREName(reactInstance)}'
		);
	}

	public function matchSelector(selector:String, ?p:PosInfos) {
		if (value == null) return wasNull('to match selector "$selector"', p);
		if (value.length == 0) return wasEmpty('to match selector "$selector"', p);

		test(
			value.is(selector),
			p,
			'Expected ${getSWName(value)} to match selector "$selector"',
			'Expected ${getSWName(value)} not to match selector "$selector"'
		);
	}
}

class ShouldReact extends Should<ReactWrapper> {
	static public function should(wrapper:ReactWrapper) {
		return new ShouldReact(wrapper);
	}

	public function new(value:ReactWrapper, inverse = false) {
		super(value, inverse);
	}

	public var not(get, never):ShouldReact;
	private function get_not() { return new ShouldReact(value, !inverse); }

	private function wasNull(msg:String, ?p:PosInfos) {
		return fail(
			'Expected ShallowWrapper $msg but was null',
			'Expected ShallowWrapper not $msg but was null',
			p
		);
	}

	private function wasEmpty(msg:String, ?p:PosInfos) {
		return fail(
			'Expected ShallowWrapper $msg but was empty',
			'Expected ShallowWrapper not $msg but was empty',
			p
		);
	}

	public function beChecked(?p:PosInfos) {
		if (value == null) return wasNull("to be checked", p);
		if (value.length == 0) return wasEmpty("to be checked", p);

		var pass = false;
		var props = value.props();

		if (props.hasOwnProperty("defaultChecked"))
			pass = props.defaultChecked || false;

		if (props.hasOwnProperty("checked"))
			pass = props.checked;

		test(
			pass,
			p,
			'Expected ${getRWName(value)} to be checked',
			'Expected ${getRWName(value)} not to be checked'
		);
	}

	public function beDisabled(?p:PosInfos) {
		if (value == null) return wasNull("to be disabled", p);
		if (value.length == 0) return wasEmpty("to be disabled", p);

		test(
			!!value.props().disabled,
			p,
			'Expected ${getRWName(value)} to be disabled',
			'Expected ${getRWName(value)} not to be disabled'
		);
	}

	public function beEmpty(?p:PosInfos) {
		if (value == null) return wasNull("to be empty", p);

		test(
			value.length == 0,
			p,
			'Expected ${getRWName(value)} to be empty',
			'Expected ${getRWName(value)} not to be empty'
		);
	}

	public function bePresent(?p:PosInfos) {
		if (value == null) return wasNull("to be present", p);

		test(
			value.length > 0,
			p,
			'Expected ${getRWName(value)} to be present',
			'Expected ${getRWName(value)} not to be present'
		);
	}

	public function containReact(reactInstance:ReactElement, ?p:PosInfos) {
		if (value == null && reactInstance == null) {
			return fail(
				"Expected ShallowWrapper to contain ReactElement but both were null",
				"Expected ShallowWrapper not to contain ReactElement but both were null",
				p
			);
		}

		if (reactInstance == null) {
			return fail(
				'Expected ${getRWName(value)} to contain ReactElement but ReactElement was null',
				'Expected ${getRWName(value)} not to contain ReactElement but ReactElement was null',
				p
			);
		}

		if (value == null) return wasNull('to contain ${getREName(reactInstance)}', p);
		if (value.length == 0) return wasEmpty('to contain ${getREName(reactInstance)}', p);

		test(
			value.contains(reactInstance),
			p,
			'Expected ${getRWName(value)} to contain ${getREName(reactInstance)}',
			'Expected ${getRWName(value)} not to contain ${getREName(reactInstance)}'
		);
	}

	public function haveClassName(className:String, ?p:PosInfos) {
		if (value == null) return wasNull('to have className "$className"', p);
		if (value.length == 0) return wasEmpty('to have className "$className"', p);

		var actualClassName = "(none)";
		var normalizedClassName = className.split(" ").join(".");

		if (!StringTools.startsWith(normalizedClassName, ".")) {
			normalizedClassName = '.$normalizedClassName';
		}

		var pass = switch (value.getElements().length) {
			case 0: false;
			case 1:
				actualClassName = value.prop("className");
				value.is(normalizedClassName);

			default:
				value.reduce(function(allMatch, node, _) {
					if (!node.is(normalizedClassName)) {
						actualClassName = node.prop("className");
						return false;
					}

					return allMatch;
				}, true);
			false;
		};

		test(
			pass,
			p,
			'Expected ${getRWName(value)}\'s className to be "$className", but was "$actualClassName"',
			'Expected ${getRWName(value)}\'s className not to be "$className"'
		);
	}

	public function haveHtml(html:String, ?p:PosInfos) {
		if (value == null) return wasNull('to have be "$html"', p);
		if (value.length == 0) return wasEmpty('to have be "$html"', p);

		var wrapperHTML = value.html();
		var useSingleQuotes = html.indexOf("'") != -1;

		var actualHTML = ~/("|')/g.replace(wrapperHTML, useSingleQuotes ? "'" : '"');
		var expectedHTML = ~/("|')/g.replace(html, useSingleQuotes ? "'" : '"');

		test(
			actualHTML == expectedHTML,
			p,
			'Expected ${getRWName(value)}\'s html to be "$expectedHTML", but was "$actualHTML"',
			'Expected ${getRWName(value)}\'s html not to be "$expectedHTML"'
		);
	}

	public function haveProp(propKey:String, ?propValue:Dynamic, ?p:PosInfos) {
		var withValue = propValue == null ? '' : ' with value "$propValue"';
		if (value == null) return wasNull('to have prop "$propKey"$withValue', p);
		if (value.length == 0) return wasEmpty('to have prop "$propKey"$withValue', p);

		var props = value.props();

		if (!props.hasOwnProperty(propKey)) {
			test(
				false,
				p,
				'Expected ${getRWName(value)} to have prop "$propKey" but it did not',
				'Expected ${getRWName(value)} not to have prop "$propKey"'
			);
		} else if (propValue == null) {
			test(
				true,
				p,
				'Expected ${getRWName(value)} to have prop "$propKey"',
				'Expected ${getRWName(value)} not to have prop "$propKey", but id did'
			);
		} else {
			var actualValue = Reflect.field(props, propKey);

			test(
				propValue == actualValue || shallowCompare(propValue, actualValue),
				p,
				'Expected ${getRWName(value)} to have prop "$propKey" with value "$propValue" but was "$actualValue"',
				'Expected ${getRWName(value)} not to have prop "$propKey" with value "$propValue"'
			);
		}
	}

	public function haveRef(refName:String, ?p:PosInfos) {
		if (value == null) return wasNull('to have ref "$refName"', p);
		if (value.length == 0) return wasEmpty('to have ref "$refName"', p);

		test(
			value.ref(refName) != null,
			p,
			'Expected ${getRWName(value)} to have ref "$refName"',
			'Expected ${getRWName(value)} not to have ref "$refName"'
		);
	}

	public function haveState(stateKey:String, ?stateValue:Dynamic, ?p:PosInfos) {
		var withValue = stateValue == null ? '' : ' with value "$stateValue"';
		if (value == null) return wasNull('to have state "$stateKey"$withValue', p);
		if (value.length == 0) return wasEmpty('to have state "$stateKey"$withValue', p);

		var state = value.state();

		if (!state.hasOwnProperty(stateKey)) {
			test(
				false,
				p,
				'Expected ${getRWName(value)} to have state "$stateKey" but it did not',
				'Expected ${getRWName(value)} not to have state "$stateKey"'
			);
		} else if (stateValue == null) {
			test(
				true,
				p,
				'Expected ${getRWName(value)} to have state "$stateKey"',
				'Expected ${getRWName(value)} not to have state "$stateKey", but id did'
			);
		} else {
			var actualValue = Reflect.field(state, stateKey);

			test(
				stateValue == actualValue || shallowCompare(stateValue, actualValue),
				p,
				'Expected ${getRWName(value)} to have state "$stateKey" with value "$stateValue" but was "$actualValue"',
				'Expected ${getRWName(value)} not to have state "$stateKey" with value "$stateValue"'
			);
		}
	}

	public function haveStyle(styleKey:String, ?styleValue:Dynamic, ?p:PosInfos) {
		var withValue = styleValue == null ? '' : ' with value "$styleValue"';
		if (value == null) return wasNull('to have style "$styleKey"$withValue', p);
		if (value.length == 0) return wasEmpty('to have style "$styleKey"$withValue', p);

		var style = value.prop('style');

		if (style == null || !style.hasOwnProperty(styleKey)) {
			test(
				false,
				p,
				'Expected ${getRWName(value)} to have style "$styleKey" but it did not',
				'Expected ${getRWName(value)} not to have style "$styleKey"'
			);
		} else if (styleValue == null) {
			test(
				true,
				p,
				'Expected ${getRWName(value)} to have style "$styleKey"',
				'Expected ${getRWName(value)} not to have style "$styleKey", but id did'
			);
		} else {
			var actualValue = Reflect.field(style, styleKey);

			test(
				styleValue == actualValue || shallowCompare(styleValue, actualValue),
				p,
				'Expected ${getRWName(value)} to have style "$styleKey" with value "$styleValue" but was "$actualValue"',
				'Expected ${getRWName(value)} not to have style "$styleKey" with value "$styleValue"'
			);
		}
	}

	public function haveTagName(tagName:String, ?p:PosInfos) {
		if (value == null) return wasNull('to have tag "$tagName"', p);
		if (value.length == 0) return wasEmpty('to have tag "$tagName"', p);

		var actualTag = value.name();

		test(
			actualTag == tagName,
			p,
			'Expected ShallowWrapper to have tag "$tagName" but had tag "$actualTag"',
			'Expected ShallowWrapper not to have tag "$tagName"'
		);
	}

	public function haveValue(?expectedValue:Dynamic, ?p:PosInfos) {
		if (value == null) return wasNull('to have value "$expectedValue"', p);
		if (value.length == 0) return wasEmpty('to have value "$expectedValue"', p);

		var props = value.props();
		var actualValue = null;

		if (props.hasOwnProperty("defaultValue"))
			actualValue = props.defaultValue;

		if (props.hasOwnProperty("value"))
			actualValue = props.value;

		test(
			(actualValue == expectedValue) && (!inverse || expectedValue != null),
			p,
			'Expected ${getRWName(value)} to have value "$expectedValue"',
			'Expected ${getRWName(value)} not to have value "$expectedValue"'
		);
	}

	public function haveText(text:String, ?p:PosInfos) {
		if (value == null) return wasNull('to have text "$text"', p);
		if (value.length == 0) return wasEmpty('to have text "$text"', p);

		var actualText = value.text();
		var pass = (text == null && actualText.length > 0) || (actualText == text);

		test(
			pass,
			p,
			'Expected ShallowWrapper to have text "$text" but had text "$actualText"',
			'Expected ShallowWrapper not to have text "$text"'
		);
	}

	public function includeText(text:String, ?p:PosInfos) {
		if (value == null) return wasNull('to include text "$text"', p);
		if (value.length == 0) return wasEmpty('to include text "$text"', p);

		if (text == null) {
			var message = 'Expected ".includeText(null)" to be given some text.
				If you are trying to assert this component has _some_ text, use the ".haveText()" matcher';

			return fail(message, message, p);
		}

		var actualText = value.text();

		test(
			actualText.indexOf(text) > -1,
			p,
			'Expected ShallowWrapper to include text "$text" but had text "$actualText"',
			'Expected ShallowWrapper not to include text "$text"'
		);
	}

	public function matchElement(reactInstance:ReactElement, ?p:PosInfos) {
		if (value == null && reactInstance == null) {
			return fail(
				"Expected ShallowWrapper to match ReactElement but both were null",
				"Expected ShallowWrapper not to match ReactElement but both were null",
				p
			);
		}

		if (reactInstance == null) {
			return fail(
				'Expected ${getRWName(value)} to match ReactElement but ReactElement was null',
				'Expected ${getRWName(value)} not to match ReactElement but ReactElement was null',
				p
			);
		}

		if (value == null) return wasNull('to match ${getREName(reactInstance)}', p);
		if (value.length == 0) return wasEmpty('to match ${getREName(reactInstance)}', p);

		var expectedWrapper = Enzyme.mount(reactInstance);

		test(
			value.debug() == expectedWrapper.debug(),
			p,
			'Expected ${getRWName(value)} to match ${getREName(reactInstance)}',
			'Expected ${getRWName(value)} not to match ${getREName(reactInstance)}'
		);
	}

	public function matchSelector(selector:String, ?p:PosInfos) {
		if (value == null) return wasNull('to match selector "$selector"', p);
		if (value.length == 0) return wasEmpty('to match selector "$selector"', p);

		test(
			value.is(selector),
			p,
			'Expected ${getRWName(value)} to match selector "$selector"',
			'Expected ${getRWName(value)} not to match selector "$selector"'
		);
	}
}

#if redux
class ShouldAction extends Should<Action> {
	static public function should(action:Action) {
		return new ShouldAction(action);
	}

	public function new(value:Action, inverse = false) {
		super(value, inverse);
	}

	public var not(get, never):ShouldAction;
	private function get_not() { return new ShouldAction(value, !inverse); }

	public function equal(enumValue:EnumValue, ?p:PosInfos) {
		var enumType = Type.getEnum(enumValue);
		var typeMatches = value.type == enumType.getName();
		var valueMatches = typeMatches && Type.enumEq(value.value, enumValue);

		test(
			typeMatches && valueMatches,
			p,
			'Expected ${value.value} to match ${enumValue}',
			'Expected ${value.value} not to match ${enumValue}'
		);
	}
}
#end
