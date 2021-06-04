var portalX = borderPortalInfo.targetPortal.x;
var portalY = borderPortalInfo.targetPortal.y;

if(surface_exists(surf))
	draw_surface(surf, portalX + borderPortalInfo.surfXOffset, portalY + borderPortalInfo.surfYOffset);

draw_sprite(
	sPlayer, borderPortalInfo.subimg, 
	portalX + borderPortalInfo.xprevOffset,
	portalY + borderPortalInfo.yprevOffset
	);