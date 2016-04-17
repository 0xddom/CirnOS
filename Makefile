OS_NAME=CirnOS
OS_VERSION=0.0.0

# Places
SRC_DIR=./src
BUILD_DIR=./build
GRUB_DIR=./grub
DIST_DIR=./dist
ISO_DIR=$(DIST_DIR)/iso
INCLUDE_DIR=./include

# Files
LINK_SCRIPT=link.ld
GRUB_BIN=stage2_eltorito
BOCHS_CFG=./bochs/bochsrc
BOCHS_TMP=./bochs/bochsrc.tmp

# Tools
SS=nasm
SFLAGS=-felf32
CC=gcc
CFLAGS=-Wall -m32 -nostdlib -I$(INCLUDE_DIR)
CFLAGS+=-fno-stack-protector -nostartfiles
LD=ld
LFLAGS=-T $(LINK_SCRIPT) -melf_i386
RM=rm -f
GISO=grub-mkrescue
GFLAGS=
GRUB=$(GRUB_DIR)/$(GRUB_BIN)
GRUB_CFG=$(GRUB_DIR)/grub.cfg
MV=qemu-system-i386
MFLAGS=
DN=dirname

OBJECTS=$(BUILD_DIR)/loader.o $(BUILD_DIR)/kmain.o $(BUILD_DIR)/term/term.o
OBJECTS+=$(BUILD_DIR)/vga/vga.o $(BUILD_DIR)/libc/string/string.o 
OBJECTS+=$(BUILD_DIR)/io/io.o $(BUILD_DIR)/io/asm_io.o

KERNEL=$(BUILD_DIR)/kernel.elf
ISO_TARGET=$(DIST_DIR)/$(OS_NAME)_$(OS_VERSION).iso

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	mkdir -p `$(DN) $@`
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s
	mkdir -p `$(DN) $@`
	$(SS) $(SFLAGS) -o $@ $<

$(KERNEL): $(OBJECTS)
	$(LD) $(LFLAGS) $^ -o $@

iso: $(ISO_TARGET)

$(ISO_TARGET): $(KERNEL) $(GRUB) $(MENU)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL) $(ISO_DIR)/boot/kernel.elf
	cp $(GRUB) $(ISO_DIR)/boot/grub/$(GRUB_BIN)
	cp $(GRUB_CFG) $(ISO_DIR)/boot/grub/grub.cfg
	$(GISO) -o $@ $(ISO_DIR)

run: $(ISO_TARGET)
	$(MV) $(MFLAGS) -cdrom $(ISO_TARGET)

.PHONY: clean
clean:
	$(RM) $(BUILD_DIR)/*.o
	$(RM) $(KERNEL)
	$(RM) -r $(ISO_DIR)/*
	$(RM) $(BOCHS_CFG)
	$(RM) bochs.log
