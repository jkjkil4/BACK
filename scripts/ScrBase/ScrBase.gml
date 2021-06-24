function setViewPos(_cameraId, _x, _y) { camera_set_view_pos(view_camera[_cameraId], _x, _y); }

function getViewW(_cameraId) { return camera_get_view_width(view_camera[_cameraId]); }
function getViewH(_cameraId) { return camera_get_view_height(view_camera[_cameraId]); }
function getViewX(_cameraId) { return camera_get_view_x(view_camera[_cameraId]); }
function getViewY(_cameraId) { return camera_get_view_y(view_camera[_cameraId]); }

function getViewBoundX(_x) {
	var viewW = getViewW(0);
	return clamp(_x - viewW / 2, 0, room_width - viewW);
}
function getViewBoundY(_y) {
	var viewH = getViewH(0);
	return clamp(_y - viewH / 2, 0, room_height - viewH);
}