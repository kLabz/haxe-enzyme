package test;

import buddy.Buddy;
import enzyme.Enzyme.configure;
import test.suite.*;
import test.suite.shallow.*;

#if react15
import enzyme.adapter.React15Adapter as Adapter;
#elseif react14
import enzyme.adapter.React14Adapter as Adapter;
#elseif react13
import enzyme.adapter.React13Adapter as Adapter;
#else
import enzyme.adapter.React16Adapter as Adapter;
#end

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
			adapter: new Adapter()
		});
	}
}
