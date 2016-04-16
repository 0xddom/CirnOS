OS_NAME=CirnOS
OS_VERSION=0.0.0

# Places
SRC_DIR=./src
BUILD_DIR=./build
GRUB_DIR=./grub
DIST_DIR=./dist
ISO_DIR=$(DIST_DIR)/iso

# Files
LINK_SCRIPT=link.ld
GRUB_BIN=stage2_eltorito
BOCHS_CFG=./bochs/bochsrc
BOCHS_TMP=./bochs/bochsrc.tmp

# Tools
SS=nasm
SFLAGS=-f elf32
CC=gcc
CFLAGS=-g -Wall
LD=ld
LFLAGS=-T $(LINK_SCRIPT) -melf_i386
RM=rm -f
GISO=genisoimage
GFLAGS=-no-emul-boot -boot-load-size 4 -A $(OS_NAME) -quiet
GFLAGS+=-boot-info-table
GRUB=$(GRUB_DIR)/$(GRUB_BIN)
MENU=$(GRUB_DIR)/menu.lst
BS=bochs
BFLAGS=-f $(BOCHS_CFG) -q

OBJECTS=$(BUILD_DIR)/loader.o
KERNEL=$(BUILD_DIR)/kernel.elf
ISO_TARGET=$(DIST_DIR)/$(OS_NAME)_$(OS_VERSION).iso

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.s
	$(SS) $(SFLAGS) -o $@ $<

$(KERNEL): $(OBJECTS)
	$(LD) $(LFLAGS) $^ -o $@

iso: $(ISO_TARGET)

$(ISO_TARGET): $(KERNEL) $(GRUB) $(MENU)
	mkdir -p $(ISO_DIR)/boot/grub
	cp $(KERNEL) $(ISO_DIR)/boot/kernel.elf
	cp $(GRUB) $(ISO_DIR)/boot/grub/$(GRUB_BIN)
	cp $(MENU) $(ISO_DIR)/boot/grub/menu.lst
	$(GISO) -R -b boot/grub/$(GRUB_BIN) $(GFLAGS) -o $@ $(ISO_DIR)

run: $(ISO_TARGET)
	sed s@OSISO@$(ISO_TARGET)@ $(BOCHS_TMP) > $(BOCHS_CFG)
	$(BS) $(BFLAGS)

.PHONY: clean
clean:
	$(RM) $(BUILD_DIR)/*.o
	$(RM) $(KERNEL)
	$(RM) -r $(ISO_DIR)/*
	$(RM) $(BOCHS_CFG)
	$(RM) bochs.log
