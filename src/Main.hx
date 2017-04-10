class Main {
	static function main()
	{
		var r = new utest.Runner();
		r.addCase(new P1P01EssenceOfComposition());

		utest.ui.Report.create(r);
		r.run();
	}
}

