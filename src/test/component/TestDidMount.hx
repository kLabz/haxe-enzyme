package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

typedef TestDidMountProps = {
	@:optional var onMount:Void->Void;
}

class TestDidMount extends ReactComponentOfProps<TestDidMountProps> {
	override public function render() {
		return jsx('
			<div>
				componentDidMount test
			</div>
		');
	}

	override function componentDidMount() {
		if (props.onMount != null) props.onMount();
	}
}
