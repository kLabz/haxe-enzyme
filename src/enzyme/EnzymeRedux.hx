package enzyme;

import js.Promise;
import redux.Redux.Action;
import redux.StoreMethods;

#if ((react >= "2.0.0") || react_next)
import react.ReactComponent.ReactFragment;
#else
import react.ReactComponent.ReactElement as ReactFragment;
#end

typedef MockedStore = {
	> StoreMethods<Dynamic>,
	subscribe:Void->Void,
	getActions:Void->Array<Action>
};

class EnzymeRedux {
	public static function mountWithStore(node:ReactFragment, store:MockedStore):ReactWrapper {
		return Enzyme.mount(node, {context: {store: store}});
	}

	public static function mountWithState(node:ReactFragment, ?state:Dynamic):ReactWrapper {
		return mountWithStore(node, createMockedStore(state));
	}

	public static function shallowWithStore(node:ReactFragment, store:MockedStore):ShallowWrapper {
		return Enzyme.shallow(node, {context: {store: store}});
	}

	public static function shallowWithState(node:ReactFragment, state:Dynamic):ShallowWrapper {
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

