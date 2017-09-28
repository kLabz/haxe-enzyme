package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

class Bar extends ReactComponent {
	override public function render() {
		return jsx('
			<div>
				Bar
			</div>
		');
	}
}
