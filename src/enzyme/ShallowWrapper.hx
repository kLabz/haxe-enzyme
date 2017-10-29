package enzyme;

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

private typedef Predicate = ShallowWrapper->Bool;

/**
	Shallow rendering is useful to constrain yourself to testing a component as a unit,
	and to ensure that your tests aren't indirectly asserting on behavior of child components.

	See https://github.com/airbnb/enzyme/blob/master/docs/api/shallow.md
**/
extern class ShallowWrapper {
	public var length(default, null):Int;

	/**
		Find every node in the render tree that matches the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/find.md
	**/
	public function find(selector:Selector):ShallowWrapper;

	/**
		Find every node in the render tree that returns true for the provided predicate function.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/findWhere.md
	**/
	public function findWhere(predicate:Predicate):ShallowWrapper;

	/**
		Remove nodes in the current wrapper that do not match the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/filter.md
	**/
	public function filter(selector:Selector):ShallowWrapper;

	/**
		Remove nodes in the current wrapper that do not return true
		for the provided predicate function.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/filterWhere.md
	**/
	public function filterWhere(predicate:Predicate):ShallowWrapper;

	/**
		Returns whether or not a given node or array of nodes is somewhere in the render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/contains.md
	**/
	public function contains(nodeOrNodes:EitherType<ReactElement, Array<ReactElement>>):Bool;

	/**
		Returns whether or not a given react element exists in the shallow render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/containsMatchingElement.md
	**/
	public function containsMatchingElement(node:ReactElement):Bool;

	/**
		Returns whether or not all the given react elements exists in the shallow render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/containsAllMatchingElement.md
	**/
	public function containsAllMatchingElement(nodes:Array<ReactElement>):Bool;

	/**
		Returns whether or not one of the given react elements exists in the shallow render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/containsAnyMatchingElement.md
	**/
	public function containsAnyMatchingElement(nodes:Array<ReactElement>):Bool;

	/**
		Returns whether or not the current render tree is equal to the given node,
		based on the expected value.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/equals.md
	**/
	public function equals(node:ReactElement):Bool;

	/**
		Returns whether or not a given react element matches the shallow render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/matchesElement.md
	**/
	public function matchesElement(node:ReactElement):Bool;

	/**
		Returns whether or not the current node has the given class name or not.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/hasClass.md
	**/
	public function hasClass(className:String):Bool;

	/**
		Returns whether or not the current node matches a provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/is.md
	**/
	public function is(selector:Selector):Bool;

	/**
		Returns whether or not the current node exists.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/exists.md
	**/
	public function exists():Bool;

	/**
		Returns whether or not the current component returns a falsy value.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/isEmptyRender.md
	**/
	public function isEmptyRender():Bool;

	/**
		Remove nodes in the current wrapper that match the provided selector.
		(inverse of `.filter()`)
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/not.md
	**/
	public function not(selector:Selector):Bool;

	/**
		Get a wrapper with all of the children nodes of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/children.md
	**/
	public function children():ShallowWrapper;

	/**
		Returns a new wrapper with child at the specified index.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/childAt.md
	**/
	public function childAt(index:Int):ShallowWrapper;

	/**
		Get a wrapper with all of the parents (ancestors) of the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/parents.md
	**/
	public function parents():ShallowWrapper;

	/**
		Get a wrapper with the direct parent of the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/parent.md
	**/
	public function parent():ShallowWrapper;

	/**
		Get a wrapper with the first ancestor of the current node to match the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/closest.md
	**/
	public function closest(selector:Selector):ShallowWrapper;

	/**
		Shallow renders the current node and returns a shallow wrapper around it.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/shallow.md
	**/
	public function shallow(?options:ShallowRenderOptions):ShallowWrapper;

	/**
		Returns a CheerioWrapper of the current node's subtree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/render.md
	**/
	public function render():Cheerio;

	/**
		A method that un-mounts the component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/unmount.md
	**/
	public function unmount():ShallowWrapper;

	/**
		Returns a string representation of the text nodes in the current render tree.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/text.md
	**/
	public function text():String;

	/**
		Returns a static HTML rendering of the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/html.md
	**/
	public function html():String;

	/**
		Returns the node at the provided index of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/get.md
	**/
	public function get(index:Int):ReactElement;

	/**
		Returns the wrapper's underlying node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/getNode.md
	**/
	public function getElement():ReactElement;

	/**
		Returns the wrapper's underlying nodes.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/getNodes.md
	**/
	public function getElements():Array<ReactElement>;

	/**
		Returns a wrapper of the node at the provided index of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/at.md
	**/
	public function at(index:Int):ShallowWrapper;

	/**
		Returns a wrapper of the first node of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/first.md
	**/
	public function first():ShallowWrapper;

	/**
		Returns a wrapper of the last node of the current wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/last.md
	**/
	public function last():ShallowWrapper;

	/**
		Returns the state of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/state.md
	**/
	public function state(?key:String):Dynamic;

	/**
		Returns the context of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/context.md
	**/
	public function context(?key:String):Dynamic;

	/**
		Returns the props of the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/props.md
	**/
	public function props():Dynamic;

	/**
		Returns the named prop of the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/prop.md
	**/
	public function prop(key:String):Dynamic;

	/**
		Returns the key of the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/key.md
	**/
	public function key():String;

	/**
		Simulates an event on the current node.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/simulate.md
	**/
	public function simulate(event:String, ?data:Dynamic):ShallowWrapper;

	/**
		Manually sets state of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/setState.md
	**/
	public function setState(nextState:Dynamic):ShallowWrapper;

	/**
		Manually sets props of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/setProps.md
	**/
	public function setProps(nextProps:Dynamic):ShallowWrapper;

	/**
		Manually sets context of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/setContext.md
	**/
	public function setContext(context:Dynamic):ShallowWrapper;

	/**
		Returns the root component.
	**/
	public function root():ShallowWrapper;

	/**
		Returns the instance of the root component.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/instance.md
	**/
	public function instance():ReactComponent;

	/**
		Calls `.forceUpdate()` on the root component instance.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/update.md
	**/
	public function update():ShallowWrapper;

	/**
		Returns a string representation of the current shallow render tree for debugging purposes.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/debug.md
	**/
	public function debug():String;

	/**
		Returns the type of the current node of the wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/type.md
	**/
	public function type():EitherType<String, Function>;

	/**
		Returns the name of the current node of the wrapper.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/name.md
	**/
	public function name():String;

	/**
		Iterates through each node of the current wrapper and executes the provided function.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/forEach.md
	**/
	public function forEach(fn:ShallowWrapper->Int->Void):ShallowWrapper;

	/**
		Maps the current array of nodes to another array.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/map.md
	**/
	public function map<T>(fn:ShallowWrapper->Int->T):Array<T>;

	/**
		Reduces the current array of nodes to a value.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/reduce.md
	**/
	public function reduce<T>(fn:T->ShallowWrapper->Int->T, ?initialValue:T):T;

	/**
		Reduces the current array of nodes to a value, from right to left.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/reduceRight.md
	**/
	public function reduceRight<T>(fn:T->ShallowWrapper->Int->T, ?initialValue:T):T;

	/**
		Returns a new wrapper with a subset of the nodes of the original wrapper,
		according to the rules of `Array#slice`.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/slice.md
	**/
	public function slice(?begin:Int, ?end:Int):ShallowWrapper;

	/**
		Taps into the wrapper method chain. Helpful for debugging.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/tap.md
	**/
	public function tap(intercepter:ShallowWrapper->Void):ShallowWrapper;

	/**
		Returns whether or not any of the nodes in the wrapper match the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/some.md
	**/
	public function some(selector:Selector):Bool;

	/**
		Returns whether or not any of the nodes in the wrapper pass the provided predicate function.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/someWhere.md
	**/
	public function someWhere(predicate:Predicate):Bool;

	/**
		Returns whether or not all of the nodes in the wrapper match the provided selector.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/every.md
	**/
	public function every(selector:Selector):Bool;

	/**
		Returns whether or not all of the nodes in the wrapper pass the provided predicate function.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/everyWhere.md
	**/
	public function everyWhere(predicate:Predicate):Bool;

	/**
		Shallow render the one non-DOM child of the current wrapper,
		and return a wrapper around the result.
		See https://github.com/airbnb/enzyme/blob/master/docs/api/ShallowWrapper/dive.md
	**/
	public function dive(options:ShallowRenderOptions):ShallowWrapper;
}
