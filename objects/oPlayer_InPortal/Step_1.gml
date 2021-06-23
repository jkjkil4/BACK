process += 0.05;
if(process >= 1) {
	x = borderPortalInfo.targetX;
	y = borderPortalInfo.targetY;
	delete borderPortalInfo;
	if(surface_exists(surf))
		surface_free(surf);
	findNearestSavePoint();
	instance_change(oPlayer_Active, false);
	exit;
}
x = lerp(borderPortalInfo.fromX, borderPortalInfo.toX, process);
y = lerp(borderPortalInfo.fromY, borderPortalInfo.toY, process);