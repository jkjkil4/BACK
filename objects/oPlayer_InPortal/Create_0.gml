surf = surface_create(getViewW(0), getViewH(0));
surface_copy(surf, 0, 0, application_surface);

room_goto(borderPortalInfo.toRoomId);