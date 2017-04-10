using P1P01EssenceOfComposition.P1P01CategoryTools;

class P1P01CategoryTools {
	public static function rightCompose<A,B,C>(g:B->C, f:A->B):A->C
		return function (a:A) return g(f(a));
}

private abstract Morphism<A,B>(A->B) from A->B to A->B {
	public inline function call(a:A):B
		return this(a);

	@:op(g*f) static inline function rightCompose<A,B,C>(g:Morphism<B,C>, f:Morphism<A,B>):Morphism<A,C>
		return function (a:A) return g.call(f.call(a));
}

class P1P01EssenceOfComposition {
	public static function id<A>(a:A):A
		return a;

	public function new() {}

	function test01_withBasicSyntax()
	{
		function f(x:Float):Int return Math.round(x);
		function g(x:Int):String return 'Answer is $x';
		function h(x:String):Bool return ~/\s3$/.match(x);

		// simple composition
		Assert.equals("Answer is 3", (g.rightCompose(f)(3.14)));

		// composition is associative
		Assert.equals(true, (h.rightCompose(g)).rightCompose(f)(3.14));
		Assert.equals(true, h.rightCompose(g.rightCompose(f))(3.14));

		// compositions with the identity
		Assert.equals(3, f.rightCompose(id)(3.14));
		Assert.equals(3, id.rightCompose(f)(3.14));
	}

	function test02_withAbstracts()
	{
		var f:Morphism<Float,Int> = function (x) return Math.round(x);
		var g:Morphism<Int,String> = function (x) return 'Answer is $x';
		var h:Morphism<String,Bool> = function (x) return ~/\s3$/.match(x);

		// // simple composition
		Assert.equals("Answer is 3", (g*f).call(3.14));

		// composition is associative
		Assert.equals(true, ((h*g)*f).call(3.14));
		Assert.equals(true, (h*(g*f)).call(3.14));

		// compositions with the identity
		Assert.equals(3, (f*id).call(3.14));
		Assert.equals(3, (id*f).call(3.14));
	}
}

