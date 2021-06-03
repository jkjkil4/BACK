function scrBound(_min, _value, _max) {
	return min(_max, max(_min, _value));
}

function scrSetViewPos(_cameraId, _x, _y) { camera_set_view_pos(view_camera[_cameraId], _x, _y); }

function scrViewW(_cameraId) { return camera_get_view_width(view_camera[_cameraId]); }
function scrViewH(_cameraId) { return camera_get_view_height(view_camera[_cameraId]); }
function scrViewX(_cameraId) { return camera_get_view_x(view_camera[_cameraId]); }
function scrViewY(_cameraId) { return camera_get_view_y(view_camera[_cameraId]); }