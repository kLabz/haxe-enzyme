package enzyme;

import js.html.DOMElement;
import haxe.extern.EitherType;
import haxe.Constraints.Function;
import cheerio.Cheerio;
import react.ReactComponent;

/**
	Many methods in enzyme's API accept a selector as an argument.

	Selectors in enzyme can fall into one of the following four categories:
	1. A valid CSS selector
	2. A ReactComponent constructor
	3. A ReactComponent's displayName
	4. Object property selector

	See https://github.com/airbnb/enzyme/blob/master/docs/api/selector.md
**/
private typedef Selector = Dynamic;

private typedef Predicate = ReactWrapper->Bool;

/**
	Full DOM rendering is ideal for use cases where you have components that may interact
	with DOM APIs, or may require the full lifecycle in order to fully test the component.

	See https://github.com/airbnb/enzyme/blob/master/docs/api/mount.md
**/
extern class ReactWrapper {
	public var length(default, null):Int;

	/**
		Find every node in the render tree that matches the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/find.md
	**/
	public function find(selector:Selector):ReactWrapper;

	/**
		Find every node in the render tree that returns true for the provided predicate function.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/findWhere.md
	**/
	public function findWhere(predicate:Predicate):ReactWrapper;

	/**
		Remove nodes in the current wrapper that do not match the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/filter.md
	**/
	public function filter(selector:Selector):ReactWrapper;

	/**
		Remove nodes in the current wrapper that do not return true for the provided predicate function.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/filterWhere.md
	**/
	public function filterWhere(predicate:Predicate):ReactWrapper;

	/**
		Removes nodes that are not host nodes; e.g., this will only return HTML nodes.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/hostNodes.md
	**/
	public function hostNodes():ReactWrapper;

	/**
		Returns whether or not a given node or array of nodes is somewhere in the render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/contains.md
	**/
	#if ((react >= "2.0.0") || react_next)
	public function contains(nodeOrNodes:ReactFragment):Bool;
	#else
	public function contains(nodeOrNodes:EitherType<ReactElement, Array<ReactElement>>):Bool;
	#end

	/**
		Returns whether or not a given react element is somewhere in the render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/containsMatchingElement.md
	**/
	#if ((react >= "2.0.0") || react_next)
	public function containsMatchingElement(node:ReactSingleFragment):Bool;
	#else
	public function containsMatchingElement(node:ReactElement):Bool;
	#end

	/**
		Returns whether or not all the given react elements are somewhere in the render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/containsAllMatchingElements.md
	**/
	#if ((react >= "2.0.0") || react_next)
	public function containsAllMatchingElements(nodes:Array<ReactSingleFragment>):Bool;
	#else
	public function containsAllMatchingElements(nodes:Array<ReactElement>):Bool;
	#end

	/**
		Returns whether or not one of the given react elements is somewhere in the render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/containsAnyMatchingElements.md
	**/
	#if ((react >= "2.0.0") || react_next)
	public function containsAnyMatchingElements(nodes:Array<ReactSingleFragment>):Bool;
	#else
	public function containsAnyMatchingElements(nodes:Array<ReactElement>):Bool;
	#end

	/**
		Returns whether or not the current root node has the given class name.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/hasClass.md
	**/
	public function hasClass(className:String):Bool;

	/**
		Returns whether or not the current node matches a provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/is.md
	**/
	public function is(selector:Selector):Bool;

	/**
		Returns whether or not the current node exists.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/exists.md
	**/
	public function exists():Bool;

	/**
		Returns whether or not the current component returns a falsy value.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/isEmptyRender.md
	**/
	public function isEmptyRender():Bool;

	/**
		Remove nodes in the current wrapper that match the provided selector. (inverse of .filter())
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/not.md
	**/
	public function not(selector:Selector):ReactWrapper;

	/**
		Get a wrapper with all of the children nodes of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/children.md
	**/
	public function children():ReactWrapper;

	/**
		Returns a new wrapper with child at the specified index.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/childAt.md
	**/
	public function childAt(index:Int):ReactWrapper;

	/**
		Get a wrapper with all of the parents (ancestors) of the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/parents.md
	**/
	public function parents():ReactWrapper;

	/**
		Get a wrapper with the direct parent of the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/parent.md
	**/
	public function parent():ReactWrapper;

	/**
		Get a wrapper with the first ancestor of the current node to match the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/closest.md
	**/
	public function closest(selector:Selector):ReactWrapper;

	/**
		Returns a CheerioWrapper of the current node's subtree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/render.md
	**/
	public function render():Cheerio;

	/**
		Returns a string representation of the text nodes in the current render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/text.md
	**/
	public function text():String;

	/**
		Returns a static HTML rendering of the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/html.md
	**/
	public function html():String;

	/**
		Returns the node at the provided index of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/get.md
	**/
	#if ((react >= "2.0.0") || react_next)
	public function get(index:Int):ReactSingleFragment;
	#else
	public function get(index:Int):ReactElement;
	#end

	/**
		Returns the wrapper's underlying node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/getNode.md
	**/
	#if ((react >= "2.0.0") || react_next)
	public function getElement():ReactSingleFragment;
	#else
	public function getElement():ReactElement;
	#end

	/**
		Returns the wrapper's underlying nodes.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/getNodes.md
	**/
	#if ((react >= "2.0.0") || react_next)
	public function getElements():Array<ReactFragment>;
	#else
	public function getElements():Array<ReactElement>;
	#end

	/**
		Returns the outer most DOMComponent of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/getDOMNode.md
	**/
	public function getDOMNode():DOMElement;

	/**
		Returns a wrapper of the node at the provided index of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/at.md
	**/
	public function at(index:Int):ReactWrapper;

	/**
		Returns a wrapper of the first node of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/first.md
	**/
	public function first():ReactWrapper;

	/**
		Returns a wrapper of the last node of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/last.md
	**/
	public function last():ReactWrapper;

	/**
		Returns the state of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/state.md
	**/
	public function state(?key:String):Dynamic;

	/**
		Returns the context of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/context.md
	**/
	public function context(?key:String):Dynamic;

	/**
		Returns the props of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/props.md
	**/
	public function props():Dynamic;

	/**
		Returns the named prop of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/prop.md
	**/
	public function prop(key:String):Dynamic;

	/**
		Returns the key of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/key.md
	**/
	public function key():String;

	/**
		Simulates an event on the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/simulate.md
	**/
	public function simulate(event:String, ?data:Dynamic):ReactWrapper;

	/**
		Manually sets state of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/setState.md
	**/
	public function setState(nextState:Dynamic):ReactWrapper;

	/**
		Manually sets props of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/setProps.md
	**/
	public function setProps(nextProps:Dynamic):ReactWrapper;

	/**
		Manually sets context of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/setContext.md
	**/
	public function setContext(context:Dynamic):ReactWrapper;

	/**
		Returns the instance of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/instance.md
	**/
	public function instance():ReactComponent;

	/**
		A method that un-mounts the component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/unmount.md
	**/
	public function unmount():ReactWrapper;

	/**
		A method that re-mounts the component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/mount.md
	**/
	public function mount():ReactWrapper;

	/**
		Calls .forceUpdate() on the root component instance.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/update.md
	**/
	public function update():ReactWrapper;

	/**
		Returns a string representation of the current render tree for debugging purposes.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/debug.md
	**/
	public function debug():String;

	/**
		Returns the type of the current node of the wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/type.md
	**/
	public function type():EitherType<String, Function>;

	/**
		Returns the name of the current node of the wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/name.md
	**/
	public function name():String;

	/**
		Iterates through each node of the current wrapper and executes the provided function
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/forEach.md
	**/
	public function forEach(fn:ReactWrapper->Int->Void):ReactWrapper;

	/**
		Maps the current array of nodes to another array.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/map.md
	**/
	public function map<T>(fn:ReactWrapper->Int->T):Array<T>;

	/**
		Returns whether or not a given react element matches the current render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/matchesElement.md
	**/
	#if ((react >= "2.0.0") || react_next)
	public function matchesElement(node:ReactSingleFragment):Bool;
	#else
	public function matchesElement(node:ReactElement):Bool;
	#end

	/**
		Reduces the current array of nodes to a value
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/reduce.md
	**/
	public function reduce<T>(fn:T->ReactWrapper->Int->T, ?initialValue:T):T;

	/**
		Reduces the current array of nodes to a value, from right to left.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/reduceRight.md
	**/
	public function reduceRight<T>(fn:T->ReactWrapper->Int->T, ?initialValue:T):T;

	/**
		Returns a new wrapper with a subset of the nodes of the original wrapper, according to the rules of Array#slice.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/slice.md
	**/
	public function slice(?begin:Int, ?end:Int):ReactWrapper;

	/**
		Taps into the wrapper method chain. Helpful for debugging.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/tap.md
	**/
	public function tap(intercepter:ReactWrapper->Void):ReactWrapper;

	/**
		Returns whether or not any of the nodes in the wrapper match the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/some.md
	**/
	public function some(selector:Selector):Bool;

	/**
		Returns whether or not any of the nodes in the wrapper pass the provided predicate function.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/someWhere.md
	**/
	public function someWhere(predicate:Predicate):Bool;

	/**
		Returns whether or not all of the nodes in the wrapper match the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/every.md
	**/
	public function every(selector:Selector):Bool;

	/**
		Returns whether or not all of the nodes in the wrapper pass the provided predicate function.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/everyWhere.md
	**/
	public function everyWhere(predicate:Predicate):Bool;

	/**
		Returns a wrapper of the node that matches the provided reference name.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/ref.md
	**/
	public function ref(refName:String):ReactWrapper;

	/**
		Unmount the component from the DOM node it's attached to.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ReactWrapper/detach.md
	**/
	public function detach():Void;
}
