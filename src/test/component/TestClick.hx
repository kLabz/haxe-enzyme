package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

typedef TestClickProps = {
	@:optional var onClick:Dynamic->Void;
}

class TestClick extends ReactComponentOfProps<TestClickProps> {
	override public function render() {
		return jsx('
			<div>
				<button onClick=${props.onClick} />
			</div>
		');
	}
}
