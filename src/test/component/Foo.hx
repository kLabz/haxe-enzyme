package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

class Foo extends ReactComponent {
	override public function render() {
		return jsx('
			<div>
				<$Bar />
				<$Bar />
				<$Bar />
			</div>
		');
	}
}
