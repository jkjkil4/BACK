function fn1() { show_message("111"); }
function fn2() { show_message("222"); }
repeat(10) {
	addTab(new Tab("aaa", fn1));
	addTab(new Tab("bbb", fn2));
}