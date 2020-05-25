CSRCS += lv_demo_stress.c

DEPPATH += --dep-path $(LVGL_DIR)/lv_examples/src/lv_demo_stress
VPATH += :$(LVGL_DIR)/lv_examples/src/lv_demo_stress
CFLAGS += "-I$(LVGL_DIR)/lv_examples/src/lv_demo_stress"

