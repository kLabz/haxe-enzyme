package enzyme;

import react.ReactComponent;

class MatchersHelper {
	public static function getSWName(node:ShallowWrapper):String {
		if (node.root() == node) {
			var instance = node.instance();
			if (instance != null && Reflect.hasField(instance, "updater")) {
				var updater:ReactShallowUpdater = Reflect.field(instance, "updater");
				var renderer = updater.renderer;

				if (renderer != null) {
					var el = renderer.element;
					if (el != null) return getREName(el);
				}
			}
		}

		if (node.length == 1) {
			var type = node.type();

			if (Reflect.hasField(type, "displayName"))
				return Reflect.field(type, "displayName");

			return type;
		} else if (node.length > 1) {
			var types = node.map(function(n, _) return getSWName(n)).join(", ");
			return '[$types]';
		}

		return "[unknown]";
	}

	public static function getREName(re:ReactElement):String {
		if (re.type != null && re.type.displayName != null)
			return re.type.displayName;

		return "[unknown]";
	}

	public static function shallowCompare(a:Dynamic, b:Dynamic):Bool {
		var aFields = Reflect.fields(a);
		var bFields = Reflect.fields(b);

		if (aFields.length != bFields.length) return false;
		if (aFields.length == 0) return a == b;

		for (field in aFields)
			if (!Reflect.hasField(b, field) || Reflect.field(b, field) != Reflect.field(a, field))
				return false;

		return true;
	}
}

extern class ReactShallowRenderer {
	@:native('_context') var context:Dynamic;
	@:native('_element') var element:ReactElement;
	@:native('_instance') var instance:ReactComponent;
	@:native('_newState') var newState:Dynamic;
	@:native('_rendered') var rendered:Dynamic;
	@:native('_rendering') var rendering:Bool;
	@:native('_updater') var updater:ReactShallowUpdater;
}

extern class ReactShallowUpdater {
	@:native('_renderer') var renderer:ReactShallowRenderer;
}
