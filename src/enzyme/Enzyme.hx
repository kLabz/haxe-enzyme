package enzyme;

import js.npm.Cheerio;
import react.ReactComponent.ReactElement;

@:jsRequire("enzyme")
extern class Enzyme {
	public static function configure(options:EnzymeOptions):Void;

	/**
		Shallow rendering is useful to constrain yourself to testing a component as a unit,
		and to ensure that your tests aren't indirectly asserting on behavior of child components.
	**/
	public static function shallow(node:ReactElement, ?options:ShallowRenderOptions):ShallowWrapper;

	/**
		Static rendering is used to render react components to static HTML
		and analyze the resulting HTML structure.

		Cheerio externs are provided via [js-kit](https://github.com/clemos/haxe-js-kit/blob/develop/js/npm/Cheerio.hx).
	**/
	public static function render(node:ReactElement, ?options:RenderOptions):Cheerio;

	/**
		Full DOM rendering is ideal for use cases where you have components that may interact
		with DOM APIs, or may require the full lifecycle in order to fully test the component.

		Full DOM rendering requires that a full DOM API be available at the global scope.
		This means that it must be run in an environment that at least “looks like” a browser environment.

		If you do not want to run your tests inside of a browser,
		the recommended approach to using mount is to depend on a library called jsdom
		which is essentially a headless browser implemented completely in JS.

		See `MountAPITests` for an example of using haxe-enzyme with jsdom.
	**/
	public static function mount(node:ReactElement, ?options:MountOptions):ReactWrapper;
}
