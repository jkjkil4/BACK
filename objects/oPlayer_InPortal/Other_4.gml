var count = instance_number(oBorderPortal);
borderPortalInfo.targetPortal = noone;
for(var i = 0; i < count; i++) {
	var portal = instance_find(oBorderPortal, i);
	if(portal.portalId == borderPortalInfo.toPortalId) {
		borderPortalInfo.targetX = portal.x + borderPortalInfo.xOffset;
		borderPortalInfo.targetY = portal.y + borderPortalInfo.yOffset;
		var viewW = scrViewW(0), viewH = scrViewH(0);
		borderPortalInfo.fromX = portal.x + borderPortalInfo.surfXOffset + viewW / 2;
		borderPortalInfo.fromY = portal.y + borderPortalInfo.surfYOffset + viewH / 2;
		borderPortalInfo.toX = scrViewBoundX(borderPortalInfo.targetX) + viewW / 2;
		borderPortalInfo.toY = scrViewBoundY(borderPortalInfo.targetY) + viewH / 2;
		borderPortalInfo.targetPortal = portal;
		break;
	}
}
if(borderPortalInfo.targetPortal == noone) {
	findNearestSavePoint();
	instance_change(oPlayer_Active, false);
	delete borderPortalInfo;
	surface_free(surf);
	exit;
}
process = 0;
