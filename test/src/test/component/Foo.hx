package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

class Foo extends ReactComponent {
	override public function render() {
		return jsx('
			<div>
				<$Bar key="1" foo="foo" />
				<$Bar key="2" foo="bar" />
				<$Bar key="3" foo="foobar" />
			</div>
		');
	}
}
