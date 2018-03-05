package enzyme;

import js.Promise;
import react.ReactComponent.ReactElement;
import redux.Redux.Action;
import redux.StoreMethods;

typedef MockedStore = {
	> StoreMethods<Dynamic>,
	subscribe:Void->Void,
	getActions:Void->Array<Action>
};

class EnzymeRedux {
	public static function mountWithStore(node:ReactElement, store:MockedStore):ReactWrapper {
		return Enzyme.mount(node, {context: {store: store}});
	}

	public static function mountWithState(node:ReactElement, ?state:Dynamic):ReactWrapper {
		return mountWithStore(node, createMockedStore(state));
	}

	public static function shallowWithStore(node:ReactElement, store:MockedStore):ShallowWrapper {
		return Enzyme.shallow(node, {context: {store: store}});
	}

	public static function shallowWithState(node:ReactElement, state:Dynamic):ShallowWrapper {
		return shallowWithStore(node, createMockedStore(state));
	}

	public static function createMockedStore(?state:Dynamic = null):MockedStore {
		if (state == null) state = {};
		var actions:Array<Action> = [];

		return {
			getState: function() return state,
			subscribe: function() {},
			getActions: function() return actions,
			dispatch: function(action:Action) {
				actions.push(action);
				return Promise.resolve(null);
			}
		};
	}
}

