surf = surface_create(800, 608);
surface_set_target(surf);
draw_surface(application_surface, 0, 0);
surface_reset_target();
x = savePointX;
y = savePointY;

process = 1;

room_restart();