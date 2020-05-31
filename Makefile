#
# Makefile
#
BIN = demo
DESTDIR = /usr
PREFIX = /local

CC=gcc
CXX=g++
CFLAGS = -Wall -Wshadow -Wundef -Wmaybe-uninitialized
CFLAGS += -O3 -g3 -I./

# directory for local libs
LDFLAGS = -L$(DESTDIR)$(PREFIX)/lib
LIBS += -lstdc++ -lm

VPATH =

$(info LDFLAGS ="$(LDFLAGS)")

LVGL_DIR = lvgl

include $(LVGL_DIR)/lvgl.mk
include $(LVGL_DIR)/lv_drivers/lv_drivers.mk
include $(LVGL_DIR)/lv_examples/lv_examples.mk

# folder for object files
OBJDIR = ./obj

CSRCS += $(wildcard *.c)

COBJS = $(patsubst %.c,$(OBJDIR)/%.o,$(CSRCS))

SRCS = $(CSRCS)
OBJS = $(COBJS)

#.PHONY: clean

all: default

$(OBJDIR)/%.o: %.c
	@mkdir -p $(OBJDIR)
	@$(CC)  $(CFLAGS) -c $< -o $@
	@echo "CC $<"

default: $(OBJS)
	$(CC) -o $(BIN) $(OBJS) $(LDFLAGS) $(LIBS)

#	nothing to do but will print info
nothing:
	$(info OBJS ="$(OBJS)")
	$(info SRCS ="$(SRCS)")
	$(info DONE)


clean:
	rm -f $(OBJS)

