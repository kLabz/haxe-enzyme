package test;

import buddy.Buddy;
import test.suite.*;

class EnzymeTests implements Buddy<[
	StaticAPITests,
	ShallowAPITests,
	ShallowFindTests
]> {}
