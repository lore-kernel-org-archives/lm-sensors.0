From: Tech2009 <tech2009@evergrove.com>
Date: Tue, 01 Sep 2009 21:27:28 +0000
Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <1251840448.3990.151.camel@Ubuntu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-zb6K1aka+eJMD3IDT6a5"
List-Id: <lm-sensors.vger.kernel.org>
References: <1251523453.13079.32.camel@Ubuntu>
In-Reply-To: <1251523453.13079.32.camel@Ubuntu>
To: lm-sensors@vger.kernel.org


--=-zb6K1aka+eJMD3IDT6a5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thank you for the suggestions.

I looked in sysfs on the factory distro, no sign of dme1737 there (see
attached). However there are other i2c devices not on my debian
install...you could be right about the direct port io, but without
disassembling the library it's hard to tell.

I tried loading dme1737 with force_start, but that made no difference
for me.

I'm going to have to determine whether the problem is with the sensors
program or the dme1737 driver. Is there a way to make the dme1737 module
dump out the debug information present in the source code?

I'm going to see if I can use the dme1737.c module source to read the
information via standard i2c calls in userland (ie i2ctools). If this
does work, I will be at a loss as to why the dme1737 module + sensors
program aren't working, but at least I'll have a viable alternative.

I will let you know if it works.


On Tue, 2009-09-01 at 20:26 +0200, Hubert Kario wrote:
> On Saturday 29 August 2009 18:03:36 Tech2009 wrote:
> > > Message: 3
> > > Date: Sat, 29 Aug 2009 10:30:25 +0200
> > > From: Hubert Kario <hka@qbs.com.pl>
> > > Subject: Re: [lm-sensors] "No sensors found!" on Intel Entry Storage
> > > System SS4200
> > > To: lm-sensors@lm-sensors.org
> > > Message-ID: <200908291030.25637.hka@qbs.com.pl>
> > > Content-Type: text/plain;  charset="iso-8859-2"
> > >
> > >
> > >
> > > and what shows dmesg?
> >
> > dmesg output after sensors-detect:
> > [ 1815.988770] i2c /dev entries driver
> >
> > dmesg output after sensors:
> > (blank)
> So there doesn't appear to be any problem...
> >
> >
> > The bundled Linux image does not appear to use the dme1737 module or
> > lmsensors. The web interface loads several closed source libraries, and
> > I'm not sure how they access the hardware.
> They may access the hardware directly, is the web interface running as root?
> Also, you may check /sys file system, look in /sys/bus/platform/drivers/ for 
> it, the module may be compiled in in the bundled image
> >
> > Is there something I should try to determine why sensors-detect sees the
> > chip but sensors does not?
> you could try one of the parameters aviable for the module, for list of all of 
> them, run:
> modinfo dme1737
> 
> 

--=-zb6K1aka+eJMD3IDT6a5
Content-Disposition: attachment; filename="modinfo dme1737.txt"
Content-Type: text/plain; name="modinfo dme1737.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

filename:       /lib/modules/2.6.26-2-686/kernel/drivers/hwmon/dme1737.ko
license:        GPL
description:    DME1737 sensors
author:         Juerg Haefliger <juergh@gmail.com>
depends:        i2c-core,hwmon-vid
vermagic:       2.6.26-2-686 SMP mod_unload modversions 686 
parm:           force_start:Force the chip to start monitoring inputs (bool)
parm:           force_id:Override the detected device ID (ushort)
parm:           force:List of adapter,address pairs to boldly assume to be present (array of short)
parm:           force_dme1737:List of adapter,address pairs which are unquestionably assumed to contain a `dme1737' chip (array of short)
parm:           probe:List of adapter,address pairs to scan additionally (array of short)
parm:           ignore:List of adapter,address pairs not to scan (array of short)


--=-zb6K1aka+eJMD3IDT6a5
Content-Disposition: attachment; filename="sys fs bus listing.txt"
Content-Type: text/plain; name="sys fs bus listing.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

bus/usb
bus/usb/drivers
bus/usb/drivers/hci_usb
bus/usb/drivers/hci_usb/new_id
bus/usb/drivers/hci_usb/bind
bus/usb/drivers/hci_usb/unbind
bus/usb/drivers/hci_usb/module
bus/usb/drivers/usblp
bus/usb/drivers/usblp/new_id
bus/usb/drivers/usblp/bind
bus/usb/drivers/usblp/unbind
bus/usb/drivers/usblp/module
bus/usb/drivers/usb-storage
bus/usb/drivers/usb-storage/new_id
bus/usb/drivers/usb-storage/bind
bus/usb/drivers/usb-storage/unbind
bus/usb/drivers/usb-storage/module
bus/usb/drivers/usbhid
bus/usb/drivers/usbhid/new_id
bus/usb/drivers/usbhid/bind
bus/usb/drivers/usbhid/unbind
bus/usb/drivers/usbhid/module
bus/usb/drivers/hiddev
bus/usb/drivers/hiddev/new_id
bus/usb/drivers/hiddev/bind
bus/usb/drivers/hiddev/unbind
bus/usb/drivers/hiddev/module
bus/usb/drivers/usb
bus/usb/drivers/usb/usb5
bus/usb/drivers/usb/usb4
bus/usb/drivers/usb/usb3
bus/usb/drivers/usb/usb2
bus/usb/drivers/usb/usb1
bus/usb/drivers/usb/bind
bus/usb/drivers/usb/unbind
bus/usb/drivers/usb/module
bus/usb/drivers/hub
bus/usb/drivers/hub/5-0:1.0
bus/usb/drivers/hub/4-0:1.0
bus/usb/drivers/hub/3-0:1.0
bus/usb/drivers/hub/2-0:1.0
bus/usb/drivers/hub/1-0:1.0
bus/usb/drivers/hub/new_id
bus/usb/drivers/hub/bind
bus/usb/drivers/hub/unbind
bus/usb/drivers/hub/module
bus/usb/drivers/usbfs
bus/usb/drivers/usbfs/new_id
bus/usb/drivers/usbfs/bind
bus/usb/drivers/usbfs/unbind
bus/usb/drivers/usbfs/module
bus/usb/devices
bus/usb/devices/5-0:1.0
bus/usb/devices/usb5
bus/usb/devices/4-0:1.0
bus/usb/devices/usb4
bus/usb/devices/3-0:1.0
bus/usb/devices/usb3
bus/usb/devices/2-0:1.0
bus/usb/devices/usb2
bus/usb/devices/1-0:1.0
bus/usb/devices/usb1
bus/scsi
bus/scsi/drivers
bus/scsi/drivers/sr
bus/scsi/drivers/sr/bind
bus/scsi/drivers/sr/unbind
bus/scsi/drivers/sd
bus/scsi/drivers/sd/bind
bus/scsi/drivers/sd/unbind
bus/scsi/drivers/sd/3:0:0:0
bus/scsi/drivers/sd/2:0:0:0
bus/scsi/drivers/sd/1:0:0:0
bus/scsi/drivers/sd/0:0:0:0
bus/scsi/devices
bus/scsi/devices/3:0:0:0
bus/scsi/devices/2:0:0:0
bus/scsi/devices/1:0:0:0
bus/scsi/devices/0:0:0:0
bus/ide
bus/ide/drivers
bus/ide/drivers/ide-cdrom
bus/ide/drivers/ide-cdrom/bind
bus/ide/drivers/ide-cdrom/unbind
bus/ide/drivers/ide-disk
bus/ide/drivers/ide-disk/bind
bus/ide/drivers/ide-disk/unbind
bus/ide/drivers/ide-disk/0.0
bus/ide/devices
bus/ide/devices/0.0
bus/isa
bus/isa/drivers
bus/isa/devices
bus/bluetooth
bus/bluetooth/drivers
bus/bluetooth/devices
bus/i2c
bus/i2c/drivers
bus/i2c/drivers/dev_driver
bus/i2c/drivers/dev_driver/bind
bus/i2c/drivers/dev_driver/unbind
bus/i2c/drivers/i2c_adapter
bus/i2c/drivers/i2c_adapter/bind
bus/i2c/drivers/i2c_adapter/unbind
bus/i2c/devices
bus/serio
bus/serio/drivers
bus/serio/drivers/atkbd
bus/serio/drivers/atkbd/bind
bus/serio/drivers/atkbd/unbind
bus/serio/drivers/atkbd/bind_mode
bus/serio/drivers/atkbd/description
bus/serio/devices
bus/serio/devices/serio1
bus/serio/devices/serio0
bus/pnp
bus/pnp/drivers
bus/pnp/drivers/serial
bus/pnp/drivers/serial/bind
bus/pnp/drivers/serial/unbind
bus/pnp/drivers/serial/00:06
bus/pnp/drivers/system
bus/pnp/drivers/system/bind
bus/pnp/drivers/system/unbind
bus/pnp/drivers/system/00:0d
bus/pnp/drivers/system/00:0c
bus/pnp/drivers/system/00:0b
bus/pnp/drivers/system/00:0a
bus/pnp/drivers/system/00:08
bus/pnp/drivers/system/00:07
bus/pnp/drivers/system/00:01
bus/pnp/devices
bus/pnp/devices/00:0d
bus/pnp/devices/00:0c
bus/pnp/devices/00:0b
bus/pnp/devices/00:0a
bus/pnp/devices/00:09
bus/pnp/devices/00:08
bus/pnp/devices/00:07
bus/pnp/devices/00:06
bus/pnp/devices/00:05
bus/pnp/devices/00:04
bus/pnp/devices/00:03
bus/pnp/devices/00:02
bus/pnp/devices/00:01
bus/pnp/devices/00:00
bus/acpi
bus/acpi/drivers
bus/acpi/devices
bus/acpi/devices/acpi
bus/pci
bus/pci/drivers
bus/pci/drivers/via-rhine
bus/pci/drivers/via-rhine/new_id
bus/pci/drivers/via-rhine/bind
bus/pci/drivers/via-rhine/unbind
bus/pci/drivers/via-rhine/module
bus/pci/drivers/uhci_hcd
bus/pci/drivers/uhci_hcd/new_id
bus/pci/drivers/uhci_hcd/bind
bus/pci/drivers/uhci_hcd/unbind
bus/pci/drivers/uhci_hcd/module
bus/pci/drivers/uhci_hcd/0000:00:1d.3
bus/pci/drivers/uhci_hcd/0000:00:1d.2
bus/pci/drivers/uhci_hcd/0000:00:1d.1
bus/pci/drivers/uhci_hcd/0000:00:1d.0
bus/pci/drivers/sata_via
bus/pci/drivers/sata_via/new_id
bus/pci/drivers/sata_via/bind
bus/pci/drivers/sata_via/unbind
bus/pci/drivers/sata_via/module
bus/pci/drivers/sata_sil24
bus/pci/drivers/sata_sil24/new_id
bus/pci/drivers/sata_sil24/bind
bus/pci/drivers/sata_sil24/unbind
bus/pci/drivers/sata_sil24/module
bus/pci/drivers/sata_sil24/0000:02:00.0
bus/pci/drivers/r8169
bus/pci/drivers/r8169/new_id
bus/pci/drivers/r8169/bind
bus/pci/drivers/r8169/unbind
bus/pci/drivers/r8169/module
bus/pci/drivers/pcnet32
bus/pci/drivers/pcnet32/new_id
bus/pci/drivers/pcnet32/bind
bus/pci/drivers/pcnet32/unbind
bus/pci/drivers/pcnet32/module
bus/pci/drivers/ohci_hcd
bus/pci/drivers/ohci_hcd/new_id
bus/pci/drivers/ohci_hcd/bind
bus/pci/drivers/ohci_hcd/unbind
bus/pci/drivers/ohci_hcd/module
bus/pci/drivers/nasGpio
bus/pci/drivers/nasGpio/new_id
bus/pci/drivers/nasGpio/bind
bus/pci/drivers/nasGpio/unbind
bus/pci/drivers/nasGpio/module
bus/pci/drivers/nasGpio/0000:00:1f.0
bus/pci/drivers/mptspi
bus/pci/drivers/mptspi/new_id
bus/pci/drivers/mptspi/bind
bus/pci/drivers/mptspi/unbind
bus/pci/drivers/mptspi/module
bus/pci/drivers/ehci_hcd
bus/pci/drivers/ehci_hcd/new_id
bus/pci/drivers/ehci_hcd/bind
bus/pci/drivers/ehci_hcd/unbind
bus/pci/drivers/ehci_hcd/module
bus/pci/drivers/ehci_hcd/0000:00:1d.7
bus/pci/drivers/e1000
bus/pci/drivers/e1000/new_id
bus/pci/drivers/e1000/bind
bus/pci/drivers/e1000/unbind
bus/pci/drivers/e1000/module
bus/pci/drivers/e1000/0000:01:00.0
bus/pci/drivers/e100
bus/pci/drivers/e100/new_id
bus/pci/drivers/e100/bind
bus/pci/drivers/e100/unbind
bus/pci/drivers/e100/module
bus/pci/drivers/ata_piix
bus/pci/drivers/ata_piix/new_id
bus/pci/drivers/ata_piix/bind
bus/pci/drivers/ata_piix/unbind
bus/pci/drivers/ata_piix/module
bus/pci/drivers/ahci
bus/pci/drivers/ahci/new_id
bus/pci/drivers/ahci/bind
bus/pci/drivers/ahci/unbind
bus/pci/drivers/ahci/module
bus/pci/drivers/ahci/0000:00:1f.2
bus/pci/drivers/i801_smbus
bus/pci/drivers/i801_smbus/new_id
bus/pci/drivers/i801_smbus/bind
bus/pci/drivers/i801_smbus/unbind
bus/pci/drivers/i801_smbus/0000:00:1f.3
bus/pci/drivers/PCI_IDE
bus/pci/drivers/PCI_IDE/new_id
bus/pci/drivers/PCI_IDE/bind
bus/pci/drivers/PCI_IDE/unbind
bus/pci/drivers/RZ1000_IDE
bus/pci/drivers/RZ1000_IDE/new_id
bus/pci/drivers/RZ1000_IDE/bind
bus/pci/drivers/RZ1000_IDE/unbind
bus/pci/drivers/PIIX_IDE
bus/pci/drivers/PIIX_IDE/new_id
bus/pci/drivers/PIIX_IDE/bind
bus/pci/drivers/PIIX_IDE/unbind
bus/pci/drivers/serial
bus/pci/drivers/serial/new_id
bus/pci/drivers/serial/bind
bus/pci/drivers/serial/unbind
bus/pci/devices
bus/pci/devices/0000:02:00.0
bus/pci/devices/0000:01:00.0
bus/pci/devices/0000:00:1f.3
bus/pci/devices/0000:00:1f.2
bus/pci/devices/0000:00:1f.0
bus/pci/devices/0000:00:1e.0
bus/pci/devices/0000:00:1d.7
bus/pci/devices/0000:00:1d.3
bus/pci/devices/0000:00:1d.2
bus/pci/devices/0000:00:1d.1
bus/pci/devices/0000:00:1d.0
bus/pci/devices/0000:00:1c.2
bus/pci/devices/0000:00:1c.0
bus/pci/devices/0000:00:02.0
bus/pci/devices/0000:00:00.0
bus/platform
bus/platform/drivers
bus/platform/drivers/dcdbas
bus/platform/drivers/dcdbas/dcdbas
bus/platform/drivers/dcdbas/bind
bus/platform/drivers/dcdbas/unbind
bus/platform/drivers/i8042
bus/platform/drivers/i8042/i8042
bus/platform/drivers/i8042/bind
bus/platform/drivers/i8042/unbind
bus/platform/drivers/serial8250
bus/platform/drivers/serial8250/bind
bus/platform/drivers/serial8250/unbind
bus/platform/drivers/serial8250/serial8250
bus/platform/devices
bus/platform/devices/dcdbas
bus/platform/devices/i8042
bus/platform/devices/serial8250
bus/platform/devices/pcspkr
bus/platform/devices/bluetooth


--=-zb6K1aka+eJMD3IDT6a5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-zb6K1aka+eJMD3IDT6a5--

