package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.ReactUtil.copy;

typedef TestFormState = {
	var checked:Bool;
	var disabled:Bool;
	var value:Int;
}

class TestForm extends ReactComponentOfState<TestFormState> {
	public function new(props) {
		super(props);
		state = {
			checked: false,
			disabled: false,
			value: 0
		};
	}

	override public function render() {
		return jsx('
			<div>
				<button className="check" onClick=$toggleCheck />
				<button className="disable" onClick=$toggleDisabled />
				<button className="value" onClick=$incValue />

				<input id="checked" defaultChecked=$true />
				<input id="not" defaultChecked=$false />

				<input id="novalue" />
				<input id="dvalue" defaultValue=${1} />

				<div>
					<input
						id="click"
						ref="ref"
						checked=${state.checked}
						disabled=${state.disabled}
						value=${state.value} />
				</div>
			</div>
		');
	}

	function toggleCheck(_) {
		setState(function(state) return copy(state, {checked: !state.checked}));
	}

	function toggleDisabled(_) {
		setState(function(state) return copy(state, {disabled: !state.disabled}));
	}

	function incValue(_) {
		setState(function(state) return copy(state, {value: ++state.value}));
	}
}
