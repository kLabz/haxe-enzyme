package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

typedef TestComponentProps = {
	@:optional var title:String;
}

class TestComponent extends ReactComponentOfProps<TestComponentProps> {
	override public function render() {
		return jsx('
			<div>
				${renderTitle()}

				<div className="content"></div>
				<div className="content"></div>
				<div className="content"></div>
			</div>
		');
	}

	function renderTitle() {
		if (props.title == null) return null;

		return jsx('<h1>${props.title}</h1>');
	}
}
