if(!instance_exists(oPlayer)) {
	var oid = instance_create_layer(x, y, layer, oPlayer_Active);
	oid.savePointX = x;
	oid.savePointY = y;
}
instance_destroy();