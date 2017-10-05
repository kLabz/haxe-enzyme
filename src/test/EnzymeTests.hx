package test;

import buddy.Buddy;
import test.suite.*;

class EnzymeTests implements Buddy<[
	StaticAPITests,
	MountAPITests,
	ShallowAPITests,
	ShallowFindTests
]> {}
