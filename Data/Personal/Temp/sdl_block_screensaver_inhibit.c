/* sdl_block_screensaver_inhibit.c */

#include <stdio.h>

void SDL_DisableScreenSaver(void) {
    fprintf(stderr, "prevented SDL_DisableScreenSaver()\n");
}
