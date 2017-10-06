package enzyme;

import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.ExprTools;

@:allow(enzyme.LifecycleSpy)
class LifecycleSpyMacro {
	static macro function injectSpy(
		method:ExprOf<String>,
		?args:ExprOf<Array<Expr>>,
		?defaultReturn:Expr
	) {
		var methodName = ExprTools.getValue(method);
		var functionArgs:Array<Expr> = [];
		var callArgs:Array<Expr> = [macro js.Lib.nativeThis];

		switch (args) {
			case {expr: EArrayDecl(arr), pos: _} if (arr.length > 0):
				functionArgs = arr;
				callArgs = callArgs.concat(arr);

			default:
		}

		var methodDecl = {
			expr: EFunction(
				null,
				{
					args: functionArgs.map(parseFunctionArg),
					expr: macro {
						$i{methodName}.call();

						var initialMethod = prototype.$methodName;
						if (initialMethod != null)
							return untyped initialMethod.call($a{callArgs});

						return $defaultReturn;
					},
					ret: null
				}
			),
			pos: Context.currentPos()
		};

		return macro {
			prototype.proto.$methodName = $methodDecl;
		};
	}

	static function parseFunctionArg(arg:Expr):FunctionArg {
		return {
			name: (function(argExpr:Expr) {
				return switch (argExpr) {
					case {expr: EConst(CIdent(name))}: name;
					default: null;
				};
			})(arg),
			type: null
		};
	}
}
