event_inherited();

function isInPortal(_id) {
	return bbox_left - 1 <= _id.bbox_left && _id.bbox_right <= bbox_right + 1;	
}
