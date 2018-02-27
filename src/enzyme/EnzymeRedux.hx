package enzyme;

import react.ReactComponent.ReactElement;

typedef MockedStore = {
	getState:Void->Dynamic,
	subscribe:Void->Void,
	dispatch:Void->Void
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

		return {
			getState: function() return state,
			subscribe: function() {},
			dispatch: function() {}
		};
	}
}

