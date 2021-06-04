ds_list_add(global.sys.menuList, id);

function isTarget() {
	return global.sys.menuList[| ds_list_size(global.sys.menuList) - 1] == id;
}
