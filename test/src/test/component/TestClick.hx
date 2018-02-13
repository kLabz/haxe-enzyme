package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

typedef TestClickProps = {
	@:optional var onClick:Void->Void;
}

typedef TestClickState = {
	var count:Int;
}

class TestClick extends ReactComponentOf<TestClickProps, TestClickState> {
	public function new(props:TestClickProps) {
		super(props);
		state = {count: 0};
	}

	override public function render() {
		return jsx('
			<div>
				<button onClick=$onClick />
				Clicked ${state.count} times.
			</div>
		');
	}

	function onClick(_) {
		setState(function(state) return {count: state.count + 1});
		if (props.onClick != null) props.onClick();
	}
}
