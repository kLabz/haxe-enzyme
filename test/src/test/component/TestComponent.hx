package test.component;

import react.ReactComponent;
import react.ReactMacro.jsx;

typedef TestComponentProps = {
	@:optional var title:String;
}

class TestComponent extends ReactComponentOfProps<TestComponentProps> {
	override public function render() {
		var style = {
			display: "inline-block"
		};

		return jsx('
			<div style=$style>
				${renderTitle()}

				<div id="header" />
				<div className="content" />
				<div className="content" />
				<p className="content" />
			</div>
		');
	}

	function renderTitle() {
		if (props.title == null) return null;

		return jsx('<h1>${props.title}</h1>');
	}
}
