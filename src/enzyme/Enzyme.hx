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
	public static function shallow(el:ReactElement, ?options:ShallowRenderOptions):ShallowWrapper;

	/**
		Static rendering is used to render react components to static HTML
		and analyze the resulting HTML structure.
	**/
	public static function render(el:ReactElement, ?options:RenderOptions):Cheerio;
}
