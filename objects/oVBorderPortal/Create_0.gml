event_inherited();

function isInPortal(_id) {
	return bbox_left - 0.5 <= _id.bbox_left && _id.bbox_right <= bbox_right + 0.5;	
}
