portalId = -1;
toRoomId = -1;
toPortalId = -1;

function isInPortal(_id) {
	return bbox_top <= _id.bbox_top && _id.bbox_bottom <= bbox_bottom;
}
function isVaild() {
	return toRoomId != -1 && toPortalId != -1;
}