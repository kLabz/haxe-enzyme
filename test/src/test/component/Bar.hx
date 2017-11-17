package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

typedef BarProps = {
	@:optional var foo:String;
}

class Bar extends ReactComponentOfProps<BarProps> {
	override public function render() {
		return jsx('
			<div className=${props.foo}>
				Bar
			</div>
		');
	}
}
