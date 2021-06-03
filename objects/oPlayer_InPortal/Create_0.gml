surf = surface_create(scrViewW(0), scrViewH(0));
surface_set_target(surf);
draw_surface(application_surface, 0, 0);
surface_reset_target();

room_goto(borderPortalInfo.toRoomId);