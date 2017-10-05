package enzyme;

import js.html.DOMElement;

typedef MountOptions = {
	/**
		Context to be passed into the component
	**/
	@:optional var context:Dynamic;

	/**
		DOM Element to attach the component to
	**/
	@:optional var attachTo:DOMElement;

	/**
		Merged contextTypes for all children of the wrapper
	**/
	@:optional var childContextTypes:Dynamic;
}
