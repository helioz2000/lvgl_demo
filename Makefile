#
# Makefile
#
BIN = demo
#BINDIR = /usr/sbin/
DESTDIR = /usr
PREFIX = /local

CC=gcc
CXX=g++
CFLAGS = -Wall -Wshadow -Wundef -Wmaybe-uninitialized
CFLAGS += -O3 -g3 -I./

# directory for local libs
LDFLAGS = -L$(DESTDIR)$(PREFIX)/lib
LIBS += -lstdc++ -lm -lmosquitto

VPATH =

$(info LDFLAGS ="$(LDFLAGS)")

#LVGL_DIR =  ${shell pwd}
LVGL_DIR = lvgl
#INC=-I$(LVGL_DIR)

#CSRCS =

include $(LVGL_DIR)/lvgl.mk
include $(LVGL_DIR)/lv_drivers/lv_drivers.mk
include $(LVGL_DIR)/lv_examples/lv_examples.mk


# folder for our object files
OBJDIR = ./obj

CSRCS += $(wildcard *.c)
CPPSRCS += $(wildcard *.cpp)
#CPPSRCS += mcp9808/mcp9808.cpp

COBJS = $(patsubst %.c,$(OBJDIR)/%.o,$(CSRCS))
//COBJS = $(patsubst %.c,%.o,$(CSRCS))
//CPPOBJS = $(patsubst %.cpp,$(OBJDIR)/%.o,$(CPPSRCS))
CPPOBJS = $(patsubst %.cpp,%.o,$(CPPSRCS))

SRCS = $(CSRCS) $(CPPSRCS)
OBJS = $(COBJS) $(CPPOBJS)


#.PHONY: clean

all: default

$(OBJDIR)/%.o: %.c
	@$(CC)  $(CFLAGS) -c $< -o $@
	@echo "CC $<"

#$(OBJDIR)/%.o: %.cpp
%.o: %.cpp
	@$(CXX)  $(CFLAGS) -c $< -o $@
	@echo "CXX $<"

default: $(OBJS)
	$(CC) -o $(BIN) $(OBJS) $(LDFLAGS) $(LIBS)

#	nothing to do but will print info
nothing:
	$(info OBJS ="$(OBJS)")
	$(info SRCS ="$(SRCS)")
	$(info DONE)


clean:
	rm -f $(OBJS)

#install:
#	install -o root $(BIN) $(BINDIR)$(BIN)
#	@echo ++++++++++++++++++++++++++++++++++++++++++++
#	@echo ++ $(BIN) has been installed in $(BINDIR)
#	@echo ++ systemctl start $(BIN)
#	@echo ++ systemctl stop $(BIN)
