var count = instance_number(oBorderPortal);
for(var i = 0; i < count; i++) {
	var portal = instance_find(oBorderPortal, i);
	if(portal.portalId == borderPortalInfo.toPortalId) {
		x = portal.x + borderPortalInfo.xOffset;
		y = portal.y + borderPortalInfo.yOffset;
		break;
	}
}
delete borderPortalInfo;
instance_change(oPlayer_Active, false);