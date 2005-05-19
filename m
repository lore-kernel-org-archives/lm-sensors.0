From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <25381867050509122191ff380@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 5/9/05, Jean Delvare <khali@linux-fr.org> wrote:
> 
> Hi Yani,
>
> If both are actually mutually exclusive, you could use a union in the
> struct definition.

That's an interesting suggestion, I've never worked with unions to
tell you the truth, but they look useful...

> Also, if we go for two different attributes, wouldn't it make sense to
> have the static one an int and the per-instance one a void*? I keep
> thinking that a pointer for the static case won't be of any help and is
> actually error-prone.

With respect to the lm_sensors chip drivers an int alone might make
sense (although for bmcsensors the void* is better), but when you
start looking at the rest of the kernel code that uses attributes the
void * looks like a very good decision.

If you have a look at my patch for net-sysfs.c for example, its hard
(impossible?) to imagine a way to do a similar thing with just an int
being passed to the callbacks, and this is using static attributes.
There are better examples out there I'm sure but I'm working down my
list slowly and net-sysfs.c happens to be at the top :-) (see the end
of this e-mail for a list of files that could potentially be updated
to use the dynamic callbacks).

> That being said, these are only my random thoughts on the topic. I am not
> going to make a decision or even emit an authoritative opinion here
> (especially not when it seems that Greg has different views). Hopefully
> I'll be back "soon", the worst seems to be behind me now.

Yes, it is starting to look like the cold hand of a dictator might be
needed ... where is Greg anyway ;-)?

Yani

Files implementing sysfs attributes:
net/core/net-sysfs.c
net/bridge/br_sysfs_br.c
net/bluetooth/hci_sysfs.c
arch/sh/drivers/dma/dma-sysfs.c
arch/arm/common/amba.c
arch/arm/kernel/ecard.c
arch/arm/kernel/time.c
arch/ppc/kernel/pci.c
arch/ppc/syslib/of_device.c
arch/ppc/syslib/ocp.c
arch/ia64/sn/kernel/tiocx.c
arch/arm26/kernel/ecard.c
arch/ppc64/kernel/of_device.c
arch/ppc64/kernel/pci.c
arch/ppc64/kernel/vio.c
arch/ppc64/kernel/sysfs.c
arch/parisc/kernel/drivers.c
arch/x86_64/kernel/mce.c
drivers/w1/w1.c
drivers/w1/w1_smem.c
drivers/w1/w1_therm.c
drivers/sh/superhyway/superhyway-sysfs.c
drivers/i2c/i2c-core.c
drivers/i2c/chips/w83l785ts.c
drivers/i2c/chips/max1619.c
drivers/i2c/chips/smsc47m1.c
drivers/i2c/chips/w83781d.c
drivers/i2c/chips/smsc47b397.c
drivers/i2c/chips/it87.c
drivers/i2c/chips/lm63.c
drivers/i2c/chips/lm75.c
drivers/i2c/chips/lm77.c
drivers/i2c/chips/lm78.c
drivers/i2c/chips/lm80.c
drivers/i2c/chips/lm83.c
drivers/i2c/chips/lm85.c
drivers/i2c/chips/lm87.c
drivers/i2c/chips/lm90.c
drivers/i2c/chips/lm92.c
drivers/i2c/chips/adm1021.c
drivers/i2c/chips/adm1025.c
drivers/i2c/chips/adm1026.c
drivers/i2c/chips/adm1031.c
drivers/i2c/chips/w83627hf.c
drivers/i2c/chips/gl518sm.c
drivers/i2c/chips/asb100.c
drivers/i2c/chips/gl520sm.c
drivers/i2c/chips/pcf8574.c
drivers/i2c/chips/pcf8591.c
drivers/i2c/chips/fscher.c
drivers/i2c/chips/fscpos.c
drivers/i2c/chips/ds1621.c
drivers/i2c/chips/sis5595.c
drivers/i2c/chips/via686a.c
drivers/i2c/chips/pc87360.c
drivers/i2c/i2c-dev.c
drivers/dio/dio-sysfs.c
drivers/mca/mca-bus.c
drivers/mmc/mmc_sysfs.c
drivers/pci/pci-sysfs.c
drivers/pci/hotplug/cpqphp_sysfs.c
drivers/pci/hotplug/shpchp_sysfs.c
drivers/pci/probe.c
drivers/pnp/interface.c
drivers/pnp/card.c
drivers/usb/core/sysfs.c
drivers/usb/host/ehci-dbg.c
drivers/usb/host/ohci-dbg.c
drivers/usb/misc/phidgetkit.c
drivers/usb/misc/cytherm.c
drivers/usb/misc/phidgetservo.c
drivers/usb/misc/usbled.c
drivers/usb/input/aiptek.c
drivers/usb/media/sn9c102_core.c
drivers/usb/media/ov511.c
drivers/usb/media/stv680.c
drivers/usb/storage/scsiglue.c
drivers/usb/gadget/file_storage.c
drivers/usb/gadget/net2280.c
drivers/usb/gadget/dummy_hcd.c
drivers/usb/gadget/pxa2xx_udc.c
drivers/usb/serial/ftdi_sio.c
drivers/base/interface.c
drivers/base/cpu.c
drivers/base/power/sysfs.c
drivers/base/firmware_class.c
drivers/base/node.c
drivers/base/dmapool.c
drivers/char/drm/drm_sysfs.c
drivers/char/tpm/tpm.c
drivers/char/mwave/mwavedd.c
drivers/char/hvcs.c
drivers/char/mbcs.c
drivers/eisa/eisa-bus.c
drivers/s390/cio/cmf.c
drivers/s390/cio/ccwgroup.c
drivers/s390/cio/chsc.c
drivers/s390/cio/device.c
drivers/s390/net/lcs.c
drivers/s390/net/qeth_sys.c
drivers/s390/net/netiucv.c
drivers/s390/net/claw.c
drivers/s390/net/cu3088.c
drivers/s390/net/ctcmain.c
drivers/s390/char/raw3270.c
drivers/s390/char/vmlogrdr.c
drivers/s390/char/tape_core.c
drivers/s390/scsi/zfcp_sysfs_driver.c
drivers/s390/scsi/zfcp_scsi.c
drivers/s390/scsi/zfcp_sysfs_port.c
drivers/s390/scsi/zfcp_sysfs_unit.c
drivers/s390/scsi/zfcp_sysfs_adapter.c
drivers/s390/block/dasd_devmap.c
drivers/s390/block/dcssblk.c
drivers/scsi/arm/powertec.c
drivers/scsi/arm/eesox.c
drivers/scsi/lpfc/lpfc_attr.c
drivers/scsi/st.c
drivers/scsi/scsi_debug.c
drivers/scsi/scsi_transport_fc.c
drivers/scsi/ipr.c
drivers/scsi/ibmvscsi/ibmvscsi.c
drivers/scsi/scsi_transport_spi.c
drivers/scsi/3w-xxxx.c
drivers/scsi/3w-9xxx.c
drivers/scsi/scsi_sysfs.c
drivers/scsi/ncr53c8xx.c
drivers/scsi/pcmcia/sym53c500_cs.c
drivers/scsi/osst.c
drivers/scsi/53c700.c
drivers/scsi/scsi_transport_iscsi.c
drivers/scsi/megaraid/megaraid_mbox.c
drivers/cpufreq/cpufreq_ondemand.c
drivers/cpufreq/freq_table.c
drivers/cpufreq/cpufreq_userspace.c
drivers/cpufreq/cpufreq_stats.c
drivers/cpufreq/cpufreq.c
drivers/infiniband/hw/mthca/mthca_provider.c
drivers/infiniband/ulp/ipoib/ipoib_main.c
drivers/infiniband/ulp/ipoib/ipoib_vlan.c
drivers/infiniband/core/sysfs.c
drivers/infiniband/core/user_mad.c
drivers/block/aoe/aoeblk.c
drivers/block/ub.c
drivers/block/genhd.c
drivers/block/viodasd.c
drivers/block/genhd.c.orig
drivers/input/mouse/psmouse.h
drivers/input/serio/serio.c
drivers/input/gameport/gameport.c
drivers/input/keyboard/atkbd.c
drivers/media/video/bttv-driver.c
drivers/media/video/videodev.c
drivers/video/fbsysfs.c
drivers/video/gbefb.c
drivers/video/w100fb.c
drivers/video/backlight/lcd.c
drivers/video/backlight/backlight.c
drivers/zorro/zorro-sysfs.c
drivers/message/i2o/device.c
drivers/message/fusion/mptscsih.c
drivers/firmware/efivars.c
drivers/ieee1394/nodemgr.c
drivers/ieee1394/sbp2.c
drivers/parisc/pdc_stable.c
drivers/pcmcia/ds.c
drivers/pcmcia/m32r_cfc.c
drivers/pcmcia/m32r_pcc.c
drivers/pcmcia/i82365.c
drivers/pcmcia/soc_common.c
drivers/pcmcia/rsrc_nonstatic.c
drivers/pcmcia/socket_sysfs.c
drivers/macintosh/therm_pm72.c
drivers/macintosh/therm_windtunnel.c
drivers/macintosh/therm_adt746x.c
kernel/ksysfs.c
kernel/power/disk.c
kernel/power/main.c
include/asm-ppc/ocp.h
