event_inherited();

function isInPortal(_id) {
	return bbox_top - 1 <= _id.bbox_top && _id.bbox_bottom <= bbox_bottom + 1;
}