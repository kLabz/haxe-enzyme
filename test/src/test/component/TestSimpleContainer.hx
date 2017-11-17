package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

class TestSimpleContainer extends ReactComponent {
	override public function render() {
		return jsx('
			<div>
				${props.children}
			</div>
		');
	}
}
