event_inherited();

var size = ds_list_size(tabList);
for(var i = 0; i < size; i++)
	delete tabList[| i];
ds_list_destroy(tabList);