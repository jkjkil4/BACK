surf = surface_create(scrViewW(0), scrViewH(0));
surface_copy(surf, 0, 0, application_surface);

room_goto(borderPortalInfo.toRoomId);