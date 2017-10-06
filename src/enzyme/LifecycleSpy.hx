package enzyme;

import react.ReactComponent;
import enzyme.LifecycleSpyMacro.injectSpy;

class LifecycleSpy {
	var isActive:Bool;
	var prototype:ReactComponentPrototype;

	public var render(default, null):SpyState;
	public var componentWillMount(default, null):SpyState;
	public var componentDidMount(default, null):SpyState;
	public var componentWillUnmount(default, null):SpyState;
	public var componentWillReceiveProps(default, null):SpyState;
	public var componentWillUpdate(default, null):SpyState;
	public var componentDidUpdate(default, null):SpyState;
	public var shouldComponentUpdate(default, null):SpyState;

	public function new(component:Class<ReactComponent>) {
		isActive = true;

		reset();
		prototype = extractPrototype(component);
		injectSpies();
	}

	public function restore():Void {
		if (!isActive) return;

		[
			'render',
			'componentWillMount',
			'componentDidMount',
			'componentWillUnmount',
			'componentWillReceiveProps',
			'componentWillUpdate',
			'componentDidUpdate',
			'shouldComponentUpdate'
		].map(restoreMethod);

		isActive = false;
	}

	public function reset():Void {
		if (!isActive) return;

		render = new SpyState();
		componentWillMount = new SpyState();
		componentDidMount = new SpyState();
		componentWillUnmount = new SpyState();
		componentWillReceiveProps = new SpyState();
		componentWillUpdate = new SpyState();
		componentDidUpdate = new SpyState();
		shouldComponentUpdate = new SpyState();
	}

	function extractPrototype(component:Class<ReactComponent>):ReactComponentPrototype {
		var proto = untyped component.prototype;

		return {
			proto: proto,

			render: getMethod(proto, 'render'),
			componentWillMount: getMethod(proto, 'componentWillMount'),
			componentDidMount: getMethod(proto, 'componentDidMount'),
			componentWillUnmount: getMethod(proto, 'componentWillUnmount'),
			componentWillReceiveProps: getMethod(proto, 'componentWillReceiveProps'),
			componentWillUpdate: getMethod(proto, 'componentWillUpdate'),
			componentDidUpdate: getMethod(proto, 'componentDidUpdate'),
			shouldComponentUpdate: getMethod(proto, 'shouldComponentUpdate')
		};
	}

	function getMethod(proto:Dynamic, method:String):Dynamic {
		if (!Reflect.hasField(proto, method)) return null;
		return Reflect.field(proto, method);
	}

	function restoreMethod(method:String):Void {
		var initialMethod = Reflect.field(prototype, method);

		if (initialMethod == null)
			Reflect.deleteField(prototype.proto, method);
		else
			Reflect.setField(prototype.proto, method, initialMethod);
	}

	function injectSpies():Void {
		injectSpy('render');
		injectSpy('componentWillMount');
		injectSpy('componentDidMount');
		injectSpy('componentWillUnmount');
		injectSpy('componentWillReceiveProps', [nextProps]);
		injectSpy('componentWillUpdate', [nextProps, nextState]);
		injectSpy('componentDidUpdate', [prevProps, prevState]);
		injectSpy('shouldComponentUpdate', [nextProps, nextState], true);
	}
}

private typedef ReactComponentPrototype = {
	var proto:Dynamic;

	var render:Null<Void->ReactElement>;
	var componentWillMount:Null<Void->Void>;
	var componentDidMount:Null<Void->Void>;
	var componentWillUnmount:Null<Void->Void>;
	var componentWillReceiveProps:Null<Dynamic->Void>;
	var componentWillUpdate:Null<Dynamic->Dynamic->Void>;
	var componentDidUpdate:Null<Dynamic->Dynamic->Void>;
	var shouldComponentUpdate:Null<Dynamic->Dynamic->Bool>;
}

private class SpyState {
	public var called(default, null):Bool = false;
	public var calledOnce(default, null):Bool = false;
	public var callCount(default, null):Int = 0;

	public function new() {}

	public function call():Void {
		called = true;
		callCount++;
		calledOnce = callCount == 1;
	}
}
