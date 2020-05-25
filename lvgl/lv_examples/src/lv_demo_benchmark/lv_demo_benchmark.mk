CSRCS += lv_demo_benchmark.c

DEPPATH += --dep-path $(LVGL_DIR)/lv_examples/src/lv_demo_benchmark
VPATH += :$(LVGL_DIR)/lv_examples/src/lv_demo_benchmark
CFLAGS += "-I$(LVGL_DIR)/lv_examples/src/lv_demo_benchmark"

