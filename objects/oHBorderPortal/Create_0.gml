event_inherited();

function isInPortal(_id) {
	return bbox_top - 0.5 <= _id.bbox_top && _id.bbox_bottom <= bbox_bottom + 0.5;
}