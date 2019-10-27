obj-m += soft_uart.o

soft_uart-objs := module.o 
#raspberry_soft_uart.o queue.o
#EXTRA_CFLAGS = -Wunused-function
RELEASE = $(shell uname -r)
# LINUX = /usr/src/linux-headers-$(RELEASE)
LINUX = /usr/src/kernels/$(RELEASE)

all:
	$(MAKE) -C $(LINUX) M=$(PWD) modules

clean:
	$(MAKE) -C $(LINUX) M=$(PWD) clean

install:
	sudo install -m 644 -c soft_uart.ko /lib/modules/$(RELEASE)
	sudo depmod
	
uninstall:
	sudo rm /lib/modules/$(RELEASE)/soft_uart.ko
	sudo depmod
	
load:
	sudo insmod /lib/modules/$(RELEASE)/soft_uart.ko 
	
unload:
	sudo rmmod soft_uart
