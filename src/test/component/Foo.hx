package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

class Foo extends ReactComponent {
	override public function render() {
		return jsx('
			<div>
				<$Bar foo="foo" />
				<$Bar foo="bar" />
				<$Bar foo="foobar" />
			</div>
		');
	}
}
