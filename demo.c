#include "lvgl/lvgl.h"
#include "lvgl/lv_drivers/display/fbdev.h"
#include "lvgl/lv_drivers/indev/evdev.h"
#include "lvgl/lv_examples/lv_examples.h"
#include <unistd.h>
//#include <stdio.h>

// display buffer size - not sure if this size is really needed
#define LV_BUF_SIZE 384000		// 800x480
// A static variable to store the display buffers
static lv_disp_buf_t disp_buf;
// Static buffer(s). The second buffer is optional
static lv_color_t lvbuf1[LV_BUF_SIZE];
static lv_color_t lvbuf2[LV_BUF_SIZE];


int main(void)
{

	// LittlevGL init
	lv_init();

	//Linux frame buffer device init
	fbdev_init();

	// Touch pointer device init
	evdev_init();

	// Initialize `disp_buf` with the display buffer(s)
	lv_disp_buf_init(&disp_buf, lvbuf1, lvbuf2, LV_BUF_SIZE);

	// Initialize and register a display driver
	lv_disp_drv_t disp_drv;
	lv_disp_drv_init(&disp_drv);
	disp_drv.flush_cb = fbdev_flush;	// flushes the internal graphical buffer to the frame buffer
	disp_drv.buffer = &disp_buf;		// set teh display buffere reference in the driver
	lv_disp_drv_register(&disp_drv);

	// Initialize and register a pointer device driver
	lv_indev_drv_t indev_drv;
	lv_indev_drv_init(&indev_drv);
	indev_drv.type = LV_INDEV_TYPE_POINTER;
	indev_drv.read_cb = evdev_read;    // defined in lv_drivers/indev/evdev.h
	lv_indev_drv_register(&indev_drv);
/*
	// Create a "Hello world!" label
	lv_obj_t * label = lv_label_create(lv_scr_act(), NULL);
	lv_label_set_text(label, "Hello world!");
	lv_obj_align(label, NULL, LV_ALIGN_CENTER, 0, 0);
*/

	lv_demo_widgets();
//	lv_demo_benchmark();
//	lv_demo_stress();

	// Handle LitlevGL tasks (tickless mode)
	while(1) {
		lv_tick_inc(5);
		lv_task_handler();
		usleep(5000);
	}
	return 0;
}