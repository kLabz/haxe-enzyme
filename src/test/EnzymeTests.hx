package test;

import buddy.Buddy;
import enzyme.Enzyme.configure;
import enzyme.adapter.React16Adapter;
import test.suite.*;

class EnzymeTests implements Buddy<[
	StaticAPITests,
	MountAPITests,
	ShallowAPITests,
	ShallowFindTests,
	LifecycleSpyTests,
	EnzymeMatchersTests
]> {
	static function __init__() {
		configure({
			adapter: new React16Adapter()
		});
	}
}
