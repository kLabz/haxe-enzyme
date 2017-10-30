package enzyme;

import haxe.Constraints.Function;
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

	public dynamic function onRender() {}
	public dynamic function onComponentWillMount() {}
	public dynamic function onComponentDidMount() {}
	public dynamic function onComponentWillUnmount() {}
	public dynamic function onComponentWillReceiveProps(nextProps) {}
	public dynamic function onComponentWillUpdate(nextProps, nextState) {}
	public dynamic function onComponentDidUpdate(prevProps, prevState) {}
	public dynamic function onShouldComponentUpdate(nextProps, nextState) {}

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

		render = new SpyState(onRender);
		componentWillMount = new SpyState(onComponentWillMount);
		componentDidMount = new SpyState(onComponentDidMount);
		componentWillUnmount = new SpyState(onComponentWillUnmount);
		componentWillReceiveProps = new SpyState(onComponentWillReceiveProps);
		componentWillUpdate = new SpyState(onComponentWillUpdate);
		componentDidUpdate = new SpyState(onComponentDidUpdate);
		shouldComponentUpdate = new SpyState(onShouldComponentUpdate);
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

	var cb:Function;

	public function new(cb:Function) {
		this.cb = cb;
	}

	public function call(args:Array<Dynamic>):Void {
		called = true;
		callCount++;
		calledOnce = callCount == 1;
		Reflect.callMethod(this, cb, args);
	}
}
