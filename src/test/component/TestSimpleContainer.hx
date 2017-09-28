package test.component;

import react.ReactComponent;

class TestSimpleContainer extends ReactComponent {
	override public function render() {
		return props.children;
	}
}
