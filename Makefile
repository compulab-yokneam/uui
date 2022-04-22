ifeq ($(PLAT),mx8mm)
OFFSET=33
else ifeq ($(PLAT),mx8mq)
OFFSET=33
else ifeq ($(PLAT),mx8mp)
OFFSET=32
else ifeq ($(PLAT),mx6)
OFFSET=1
else ifeq ($(PLAT),mx7)
OFFSET=1
else
$(error PLAT is not set or wrong)
endif

UUI=uui.img

.PHONY: all
all: $(PLAT)/$(UUI)

$(PLAT)/$(UUI): $(PLAT)/bootloader $(PLAT)/bootscript
	seek=$(OFFSET) soc=$(PLAT) tools/uui.mk
	cp -vH $(UUI) $(PLAT)/$(UUI) 
	unlink $(UUI)

$(PLAT)/bootloader:
	$(error botloader must be created by an external application)

clean:
	@rm -rf $(PLAT)/$(UUI)
