From: sharman@technologist.com (Darren)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Dependency problem during compile
Message-Id: <1073609543.32040.73.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Please note there may be a ticket in the self serve help area for this
issue. i tried to raise one but when I searched for it, it didn't
appear. So apologies if you get this information twice.
------------------------

Hi, 

I'm having compile problems when using lm sensors 2.8.2.

It appears to me that the dependancies don't get correctly worked out by
the make file.

The error I get is as follows...

make: *** No rule to make target `linux/modsetver.h', needed by
`kernel/chips/vt1211.d'.  Stop.

I enclose the Makefile and vt1211.d files below.

My Makefile configuration section is as follows.
----8<---8<----

# If your /bin/sh is not bash, change the below definition so that make
can
# find bash. Or you can hope your sh-like shell understands all scripts.
# I think so, but I have not tested it.
#SHELL := /usr/bin/bash

# The currently running kernel version. This is used right below to
# determine where the kernel sources can be found.
KERNELVERSION := 2.4.21

# The location of linux itself. This is used to find the kernel headers
# and other things.
LINUX := /home/darren/MiniMyth/kernelNewTry/linux-2.4.21
#LINUX := $(shell if [ -L /lib/modules/$(KERNELVERSION)/build ] ; \
#	then echo "/lib/modules/$(KERNELVERSION)/build" ; \
#	else echo "/usr/src/linux" ; fi)
LINUX_HEADERS := $(LINUX)/include

# Uncomment the third line on SMP systems if the magic invocation fails.
It
# is a bit complicated because SMP configuration changed around kernel
2.1.130
SMP := $(shell if grep -q '^SMP[[:space:]]*=' $(LINUX)/Makefile || \
                  grep -q
'^[[:space:]]*\#define[[:space:]]*CONFIG_SMP[[:space:]]*1'
$(LINUX_HEADERS)/linux/autoconf.h ; \
               then echo 1; else echo 0; fi)
#SMP := 0
#SMP := 1

# Uncomment the second or third line if the magic invocation fails.
# We need to know whether CONFIG_MODVERSIONS is defined.
#MODVER := $(shell if cat $(LINUX_HEADERS)/linux/config.h
$(LINUX_HEADERS)/linux/autoconf.h 2>/dev/null | grep -q
'^[[:space:]]*\#define[[:space:]]*CONFIG_MODVERSIONS[[:space:]]*1'; then
echo 1; else echo 0; fi)
#MODVER := 0
MODVER := 1

# Uncomment the second line if you are a developer. This will enable
many
# additional warnings at compile-time
WARN := 0
#WARN := 1

# Uncomment the second line if you want to get (loads of) debug
information
# at run-time.
# Not recommended, unless you are actually debugging the code
DEBUG := 0
#DEBUG := 1

# If you want to install at some other place then at from which you will
run
# everything, set DESTDIR to the extra prefix.
DESTDIR := /var/lib/mythroothair

# This is the prefix that will be used for almost all directories below.
PREFIX := /var/lib/mythroothair/usr/local

# This is the main modules directory into which the modules will be
installed.
# The magic invocation will return something like this:
#   /lib/modules/2.2.15-ac9
#MODDIR := /lib/modules/`grep UTS_RELEASE
$(LINUX_HEADERS)/linux/version.h|cut -f 2 -d'"'`/misc
#MODPREF := /lib/modules/$(KERNELVERSION)
#MODPREF := /lib/modules/`grep UTS_RELEASE
$(LINUX_HEADERS)/linux/version.h|cut -f 2 -d'"'`
#MODPREF := /lib/modules/$(shell $(CC) -I$(LINUX_HEADERS) -E
etc/config.c | grep uts_release |cut -f 2 -d'"')
MODPREF := /home/darren/MiniMyth/lmsensors/OutputModulesI2c

# This is the directory where sensors.conf will be installed, if no
other
# configuration file is found
ETCDIR := /var/lib/mythroothair/etc

# You should not need to change this. It is the directory into which the
# library files (both static and shared) will be installed.
LIBDIR := $(PREFIX)/lib

# You should not need to change this. It is the directory into which the
# executable program files will be installed. BINDIR for programs that
are
# also useful for normal users, SBINDIR for programs that can only be
run
# by the superuser.
# Note that not all programs in this package are really installed;
# some are just examples. You can always install them by hand, of
# course.
BINDIR := $(PREFIX)/bin
SBINDIR := $(PREFIX)/sbin

# You should not need to change this. It is the basic directory into
which
# include files will be installed. The actual directory will be
# $(INCLUDEDIR)/linux for system include files, and
$(INCLUDEDIR)/sensors
# for library include files. If PREFIX equals the default
/usr/local/bin,
# you will be able to use '#include <linux/sensors.h>' regardless of the
# current kernel selected.
INCLUDEDIR := /home/darren/MiniMyth/kernelNewTry/linux-2.4.21/include
SYSINCLUDEDIR := $(INCLUDEDIR)/linux
LIBINCLUDEDIR := $(INCLUDEDIR)/sensors

# You should not need to change this. It is the base directory under
which the
# manual pages will be installed.
MANDIR := $(PREFIX)/man

# You should not need to change this. It defines the manual owner and
group
# as which manual pages are installed.
MANOWN := root
MANGRP := root

MACHINE := $(shell uname -m)

# Extra non-default programs to build; e.g., sensord
# PROG_EXTRA := sensord

# Set these to add preprocessor or compiler flags, or use
# environment variables
# CFLAGS :# CPPFLAGS :
##################################################
# Below this, nothing should need to be changed. #
##################################################

---8<---8<---

The contents of vt1211.d is as follows

---8<---8<---

kernel/chips/vt1211.d kernel/chips/vt1211.o: Makefile
kernel/chips/Module.mk  kernel/chips/vt1211.c \
 
/home/darren/MiniMyth/kernelNewTry/linux-2.4.21/include/linux/modversions.h \
  ./linux/modsetver.h ./linux/modules/53c700.ver
./linux/modules/8390.ver \
  ./linux/modules/ac97_codec.ver ./linux/modules/ac97.ver \
  ./linux/modules/aci.ver ./linux/modules/acpi_ksyms.ver \
  ./linux/modules/acsi.ver ./linux/modules/ad1848.ver \
  ./linux/modules/adb.ver ./linux/modules/af_ax25.ver \
  ./linux/modules/af_ipx.ver ./linux/modules/af_netlink.ver \
  ./linux/modules/af_spx.ver ./linux/modules/afs.ver \
  ./linux/modules/agpgart_be.ver ./linux/modules/aironet4500_card.ver \
  ./linux/modules/aironet4500_core.ver ./linux/modules/airo.ver \
  ./linux/modules/amd7930.ver ./linux/modules/arcnet.ver \
  ./linux/modules/arlan.ver ./linux/modules/arp_tables.ver \
  ./linux/modules/ataraid.ver ./linux/modules/atm_misc.ver \
  ./linux/modules/atyfb_base.ver ./linux/modules/au1000_gpio.ver \
  ./linux/modules/audio_syms.ver ./linux/modules/audio.ver \
  ./linux/modules/auto_irq.ver ./linux/modules/b1dma.ver \
  ./linux/modules/b1pcmcia.ver ./linux/modules/b1.ver \
  ./linux/modules/base.ver ./linux/modules/bbc_i2c.ver \
  ./linux/modules/blkpg.ver ./linux/modules/bpck6.ver \
  ./linux/modules/bttv-if.ver ./linux/modules/buffer.ver \
  ./linux/modules/busmouse.ver ./linux/modules/capifs.ver \
  ./linux/modules/capiutil.ver ./linux/modules/cdrom.ver \
  ./linux/modules/check.ver ./linux/modules/chipreg.ver \
  ./linux/modules/cmdlinepart.ver ./linux/modules/cmdline.ver \
  ./linux/modules/cmp.ver ./linux/modules/com20020.ver \
  ./linux/modules/common.ver ./linux/modules/comx.ver \
  ./linux/modules/config.ver ./linux/modules/console.ver \
  ./linux/modules/context.ver ./linux/modules/cpia.ver \
  ./linux/modules/cpufreq.ver ./linux/modules/cpuid.ver \
  ./linux/modules/crc32.ver ./linux/modules/cs.ver \
  ./linux/modules/cyber2000fb.ver ./linux/modules/cycx_drv.ver \
  ./linux/modules/DAC960.ver ./linux/modules/dbri.ver \
  ./linux/modules/dcache.ver ./linux/modules/ddp.ver \
  ./linux/modules/dec_and_lock.ver ./linux/modules/deflate_syms.ver \
  ./linux/modules/Divas_mod.ver ./linux/modules/dmasound_core.ver \
  ./linux/modules/dm-table.ver ./linux/modules/dm-target.ver \
  ./linux/modules/dquot.ver ./linux/modules/ds.ver \
  ./linux/modules/edp2.ver ./linux/modules/eicon_mod.ver \
  ./linux/modules/exec_domain.ver ./linux/modules/fas216.ver \
  ./linux/modules/fatfs_syms.ver ./linux/modules/fbcmap.ver \
  ./linux/modules/fbcon-afb.ver ./linux/modules/fbcon-cfb16.ver \
  ./linux/modules/fbcon-cfb24.ver ./linux/modules/fbcon-cfb2.ver \
  ./linux/modules/fbcon-cfb32.ver ./linux/modules/fbcon-cfb4.ver \
  ./linux/modules/fbcon-cfb8.ver ./linux/modules/fbcon-hga.ver \
  ./linux/modules/fbcon-ilbm.ver ./linux/modules/fbcon-iplan2p2.ver \
  ./linux/modules/fbcon-iplan2p4.ver ./linux/modules/fbcon-iplan2p8.ver
\
  ./linux/modules/fbcon-mac.ver ./linux/modules/fbcon-mfb.ver \
  ./linux/modules/fbcon.ver ./linux/modules/fbcon-vga-planes.ver \
  ./linux/modules/fbcon-vga.ver ./linux/modules/fbgen.ver \
  ./linux/modules/fbmem.ver ./linux/modules/fbmon.ver \
  ./linux/modules/fc_syms.ver ./linux/modules/fc.ver \
  ./linux/modules/filemap.ver ./linux/modules/filesystems.ver \
  ./linux/modules/freq_table.ver ./linux/modules/ftape_syms.ver \
  ./linux/modules/g450_pll.ver ./linux/modules/gameport.ver \
  ./linux/modules/generic_serial.ver ./linux/modules/genhd.ver \
  ./linux/modules/gen_probe.ver ./linux/modules/hcd.ver \
  ./linux/modules/hdlcdrv.ver ./linux/modules/hdlc_generic.ver \
  ./linux/modules/hermes.ver ./linux/modules/hil_mlc.ver \
  ./linux/modules/hisax_isac.ver ./linux/modules/hp_psaux.ver \
  ./linux/modules/hp_sdc.ver ./linux/modules/i2c-algo-bit.ver \
  ./linux/modules/i2c-algo-ite.ver ./linux/modules/i2c-algo-pcf.ver \
  ./linux/modules/i2c-core.ver ./linux/modules/i2c-old.ver \
  ./linux/modules/i2c-proc.ver ./linux/modules/i2o_block.ver \
  ./linux/modules/i2o_config.ver ./linux/modules/i2o_core.ver \
  ./linux/modules/i2o_lan.ver ./linux/modules/i2o_pci.ver \
  ./linux/modules/i2o_proc.ver ./linux/modules/i2o_scsi.ver \
  ./linux/modules/i386_ksyms.ver ./linux/modules/ide-disk.ver \
  ./linux/modules/ide-dma.ver ./linux/modules/ide-iops.ver \
  ./linux/modules/ide-io.ver ./linux/modules/ide-lib.ver \
  ./linux/modules/ide-probe.ver ./linux/modules/ide-proc.ver \
  ./linux/modules/ide-taskfile.ver ./linux/modules/ide.ver \
  ./linux/modules/idt77105.ver ./linux/modules/ieee1394_core.ver \
  ./linux/modules/inflate_syms.ver ./linux/modules/init.ver \
  ./linux/modules/input.ver ./linux/modules/ipcommon.ver \
  ./linux/modules/ip_conntrack_standalone.ver \
  ./linux/modules/ip_fw_compat.ver ./linux/modules/ip_gre.ver \
  ./linux/modules/ipip.ver ./linux/modules/ipmi_msghandler.ver \
  ./linux/modules/ipmi_watchdog.ver
./linux/modules/ip_nat_standalone.ver \
  ./linux/modules/ip_tables.ver ./linux/modules/irport.ver \
  ./linux/modules/irsyms.ver ./linux/modules/isapnp.ver \
  ./linux/modules/isdn_common.ver ./linux/modules/isdnhdlc.ver \
  ./linux/modules/isense.ver ./linux/modules/iso.ver \
  ./linux/modules/ixj.ver ./linux/modules/journal.ver \
  ./linux/modules/kcapi.ver ./linux/modules/kcopyd.ver \
  ./linux/modules/keyboard.ver ./linux/modules/kmod.ver \
  ./linux/modules/ksyms.ver ./linux/modules/ktrace.ver \
  ./linux/modules/lapb_iface.ver ./linux/modules/libata.ver \
  ./linux/modules/llc_macinit.ver ./linux/modules/ll_rw_blk.ver \
  ./linux/modules/lockd_syms.ver ./linux/modules/loop.ver \
  ./linux/modules/mach64_accel.ver ./linux/modules/mac_hid.ver \
  ./linux/modules/matroxfb_accel.ver ./linux/modules/matroxfb_base.ver \
  ./linux/modules/matroxfb_DAC1064.ver ./linux/modules/matroxfb_g450.ver
\
  ./linux/modules/matroxfb_misc.ver ./linux/modules/matroxfb_Ti3026.ver
\
  ./linux/modules/mca.ver ./linux/modules/md.ver \
  ./linux/modules/memory.ver ./linux/modules/mempool.ver \
  ./linux/modules/microcode.ver ./linux/modules/midi_syms.ver \
  ./linux/modules/mii.ver ./linux/modules/miropcm20-rds-core.ver \
  ./linux/modules/misc.ver ./linux/modules/modedb.ver \
  ./linux/modules/mptbase.ver ./linux/modules/mptctl.ver \
  ./linux/modules/mptlan.ver ./linux/modules/mptscsih.ver \
  ./linux/modules/mpu401.ver ./linux/modules/msdosfs_syms.ver \
  ./linux/modules/msdos.ver ./linux/modules/msgqueue.ver \
  ./linux/modules/msnd.ver ./linux/modules/msr.ver \
  ./linux/modules/mtdconcat.ver ./linux/modules/mtdcore.ver \
  ./linux/modules/mtdpart.ver ./linux/modules/mtrr.ver \
  ./linux/modules/nand_ecc.ver ./linux/modules/nand_ids.ver \
  ./linux/modules/nand.ver ./linux/modules/netfilter.ver \
  ./linux/modules/net_init.ver ./linux/modules/netsyms.ver \
  ./linux/modules/newport.ver ./linux/modules/nls_base.ver \
  ./linux/modules/nm256_audio.ver ./linux/modules/nubus_syms.ver \
  ./linux/modules/nvram.ver ./linux/modules/ohci1394.ver \
  ./linux/modules/open.ver ./linux/modules/opl3.ver \
  ./linux/modules/orinoco.ver ./linux/modules/ov511.ver \
  ./linux/modules/p8022.ver ./linux/modules/page_alloc.ver \
  ./linux/modules/pageattr.ver ./linux/modules/page_buf.ver \
  ./linux/modules/parport_pc.ver ./linux/modules/pc300_drv.ver \
  ./linux/modules/pcigame.ver ./linux/modules/pci_hotplug_core.ver \
  ./linux/modules/pci_hotplug_util.ver ./linux/modules/pci_socket.ver \
  ./linux/modules/pci.ver ./linux/modules/phonedev.ver \
  ./linux/modules/pm.ver ./linux/modules/pnpbios_core.ver \
  ./linux/modules/ppp_async.ver ./linux/modules/ppp_generic.ver \
  ./linux/modules/pppox.ver ./linux/modules/printk.ver \
  ./linux/modules/processor.ver ./linux/modules/proc.ver \
  ./linux/modules/profile.ver ./linux/modules/psnap.ver \
  ./linux/modules/pty.ver ./linux/modules/pwc-uncompress.ver \
  ./linux/modules/queue.ver ./linux/modules/random.ver \
  ./linux/modules/raw.ver ./linux/modules/ray_cs.ver \
  ./linux/modules/rbtree.ver ./linux/modules/redboot.ver \
  ./linux/modules/resources.ver ./linux/modules/root.ver \
  ./linux/modules/rrm.ver ./linux/modules/rtc.ver \
  ./linux/modules/rwsem-spinlock.ver ./linux/modules/rwsem.ver \
  ./linux/modules/sa1100fb.ver ./linux/modules/sb_common.ver \
  ./linux/modules/scsi_syms.ver ./linux/modules/scx200.ver \
  ./linux/modules/sdladrv.ver ./linux/modules/selection.ver \
  ./linux/modules/sequencer_syms.ver ./linux/modules/serial.ver \
  ./linux/modules/serio.ver ./linux/modules/setup-pci.ver \
  ./linux/modules/sgicons.ver ./linux/modules/shmem.ver \
  ./linux/modules/shmiq.ver ./linux/modules/signal.ver \
  ./linux/modules/sis_main.ver ./linux/modules/slhc.ver \
  ./linux/modules/sonypi.ver ./linux/modules/sound_core.ver \
  ./linux/modules/sound_syms.ver ./linux/modules/sticon.ver \
  ./linux/modules/sticore.ver ./linux/modules/stifb.ver \
  ./linux/modules/suni.ver ./linux/modules/sunrpc_syms.ver \
  ./linux/modules/su.ver ./linux/modules/syms.ver \
  ./linux/modules/syncppp.ver ./linux/modules/sysrq.ver \
  ./linux/modules/sys.ver ./linux/modules/tc.ver
./linux/modules/time.ver \
  ./linux/modules/tms380tr.ver ./linux/modules/tty_ioctl.ver \
  ./linux/modules/tty_io.ver ./linux/modules/uart401.ver \
  ./linux/modules/uPD98402.ver ./linux/modules/usbserial.ver \
  ./linux/modules/usb.ver ./linux/modules/usema.ver \
  ./linux/modules/userspace.ver ./linux/modules/util.ver \
  ./linux/modules/vfatfs_syms.ver ./linux/modules/via-pmu.ver \
  ./linux/modules/videodev.ver ./linux/modules/wanmain.ver \
  ./linux/modules/xfs_globals.ver ./linux/modules/xor.ver \
  ./linux/modules/yenta.ver ./linux/modules/z85230.ver \
  ./linux/modules/zftape_syms.ver ./linux/modules/zorro.ver \
  ./linux/module.h ./linux/slab.h ./linux/proc_fs.h ./linux/ioport.h \
  ./linux/sysctl.h ./linux/types.h ./linux/i2c.h ./linux/i2c-proc.h \
  ./linux/init.h ./asm/errno.h ./asm/io.h version.h \
  kernel/include/sensors_vid.h
---8<---8<----

If I edit the vt1211.d file and correct the paths the compile continues,
but then of course fails on the next .d file where the paths are wrong. 

Please can you tell me what is wrong ?

Thanks for your help,

Darren
P.S. I read and reread the docs, googled for the answer and searched the
self serve help section before writting in. So I really have tried to
help myself before asking you. :-)
-- 
Darren <sharman@technologist.com>
