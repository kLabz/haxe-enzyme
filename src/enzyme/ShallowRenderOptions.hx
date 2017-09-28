package enzyme;

typedef ShallowRenderOptions = {
	/**
		Context to be passed into the component
	**/
	@:optional var context:Dynamic;

	/**
		If set to true, `componentDidMount` is not called on the component,
		and `componentDidUpdate` is not called after `setProps` and `setContext`.
		Default to `false`.
	**/
	@:optional var disableLifecycleMethods:Bool;

	/**
		If set to true, the entire lifecycle (`componentDidMount` and `componentDidUpdate`)
		of the React component is called.

		The current default value is `false` with enzyme v2,
		but the next major version will flip the default value to `true`.
	**/
	@:optional var lifecycleExperimental:Bool;
}
