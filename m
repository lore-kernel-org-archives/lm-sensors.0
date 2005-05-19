From: starless@spin.it (Marco De Vitis)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: p4b_smbus and other modules
Message-Id: <485309134.20040121132926@spin.it>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here I am again with a dumb question, as I promised on IRC (nick
"mdv"). ;)
On my Asus P4PE, Mandrake Linux 9.0, lm_sensors 2.8.2, sensors works
fine if I manually issue the following commands:

insmod p4b_smbus
modprobe i2c-core
modprobe i2c-i801
modprobe i2c-dev
modprobe i2c-proc
modprobe asb100

(BTW, is i2c-dev really needed? And what about module "eeprom", which
sensors-detect suggested to add? I suppose it's related to the "Chip
`SPD EEPROM'" it detects, but I don't know what it is...)

The problem is that, when issuing the first command "insmod
p4b_smbus", lots of error lines are reported to syslog.
If I add p4b_smbus in /etc/modules to make it load at boot time, those
errors appear again, preventing other non-i2c modules from loading
correctly.

I attach the error log. As you can see, all following i2c modules are
loaded fine (last six lines in the file).

Moreover, I found a p4b_smbus module already installed on my system:
/lib/modules/2.4.19-35mdk/kernel/3rdparty/p4b_smbus/p4b_smbus.o.gz

While I manually copied the one built from lm_sensors sources here:
/lib/modules/2.4.19-35mdk/kernel/drivers/hotplug/p4b_smbus.o

When I do insmod by hand, the system tells me it's using the latter.
Now, you might have understood that I'm rather newbie with regards to
modules... what should I do with these two modules? Where should I
copy the new one? What should I do with the old one? Is this related
to the errors reported?

Thanks a lot.

-- 
Ciao,
  Marco.

.."Low", David Bowie 1977
-------------- next part --------------
Jan 21 12:43:37 gpserver kernel: i801smbus: found Intel ICH4 (82801DB).
Jan 21 12:43:37 gpserver kernel: PCI: Found IRQ 9 for device 00:1f.3
Jan 21 12:43:37 gpserver kernel: PCI: Sharing IRQ 9 with 00:1f.5
Jan 21 12:43:37 gpserver kernel: i801smbus: Enabled
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: pcimodules is scanning more than  ...
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: Setup 8139too 8139cp rivafb snd-intel8x0 i810_audio i810-tco i810_rng ehci-hcd usb-uhci uhci usb-uhci uhci usb-uhci uhci for PCI slot 00:1f.3
Jan 21 12:43:37 gpserver kernel: 8139cp 10/100 PCI Ethernet driver v0.0.7 (Feb 27, 2002)
Jan 21 12:43:37 gpserver insmod: /lib/modules/2.4.19-35mdk/kernel/drivers/net/8139cp.o.gz: init_module: No such device
Jan 21 12:43:37 gpserver insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod /lib/modules/2.4.19-35mdk/kernel/drivers/net/8139cp.o.gz failed
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod 8139cp failed
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... can't load module 8139cp
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: missing kernel or user mode driver 8139cp 
Jan 21 12:43:37 gpserver kernel: rivafb: cannot reserve FB region
Jan 21 12:43:37 gpserver insmod: /lib/modules/2.4.19-35mdk/kernel/drivers/video/riva/rivafb.o.gz: init_module: No such device
Jan 21 12:43:37 gpserver insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod /lib/modules/2.4.19-35mdk/kernel/drivers/video/riva/rivafb.o.gz failed
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod rivafb failed
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... can't load module rivafb
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: missing kernel or user mode driver rivafb 
Jan 21 12:43:37 gpserver kernel: Intel ICH soundcard not found or device busy
Jan 21 12:43:37 gpserver insmod: /lib/modules/2.4.19-35mdk/kernel/sound/pci/snd-intel8x0.o.gz: init_module: No such device
Jan 21 12:43:37 gpserver insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod /lib/modules/2.4.19-35mdk/kernel/sound/pci/snd-intel8x0.o.gz failed
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod snd-intel8x0 failed
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... can't load module snd-intel8x0
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: missing kernel or user mode driver snd-intel8x0 
Jan 21 12:43:37 gpserver kernel: i810_rng: RNG not detected
Jan 21 12:43:37 gpserver insmod: /lib/modules/2.4.19-35mdk/kernel/drivers/char/i810_rng.o.gz: init_module: No such device
Jan 21 12:43:37 gpserver insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod /lib/modules/2.4.19-35mdk/kernel/drivers/char/i810_rng.o.gz failed
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod i810_rng failed
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... can't load module i810_rng
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: missing kernel or user mode driver i810_rng 
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... blacklisted module:  usb-uhci
Jan 21 12:43:37 gpserver kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Jan 21 12:43:37 gpserver insmod: /lib/modules/2.4.19-35mdk/kernel/drivers/usb/uhci.o.gz: init_module: No such device
Jan 21 12:43:37 gpserver insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod /lib/modules/2.4.19-35mdk/kernel/drivers/usb/uhci.o.gz failed
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod uhci failed
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... can't load module uhci
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: missing kernel or user mode driver uhci 
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... blacklisted module:  usb-uhci
Jan 21 12:43:37 gpserver kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Jan 21 12:43:37 gpserver insmod: /lib/modules/2.4.19-35mdk/kernel/drivers/usb/uhci.o.gz: init_module: No such device
Jan 21 12:43:37 gpserver insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod /lib/modules/2.4.19-35mdk/kernel/drivers/usb/uhci.o.gz failed
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod uhci failed
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... can't load module uhci
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: missing kernel or user mode driver uhci 
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... blacklisted module:  usb-uhci
Jan 21 12:43:37 gpserver kernel: uhci.c: USB Universal Host Controller Interface driver v1.1
Jan 21 12:43:37 gpserver insmod: /lib/modules/2.4.19-35mdk/kernel/drivers/usb/uhci.o.gz: init_module: No such device
Jan 21 12:43:37 gpserver insmod: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters.       You may find more information in syslog or the output from dmesg
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod /lib/modules/2.4.19-35mdk/kernel/drivers/usb/uhci.o.gz failed
Jan 21 12:43:37 gpserver modprobe: modprobe: insmod uhci failed
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: ... can't load module uhci
Jan 21 12:43:37 gpserver /etc/hotplug/pci.agent: missing kernel or user mode driver uhci 
Jan 21 12:43:59 gpserver kernel: i2c-core.o: i2c core module version 2.8.2 (20031211)
Jan 21 12:44:06 gpserver kernel: i2c-i801 version 2.8.2 (20031211)
Jan 21 12:44:12 gpserver kernel: i2c-dev.o: i2c /dev entries driver module version 2.8.2 (20031211)
Jan 21 12:44:12 gpserver kernel: i2c-dev.o: Registered 'SMBus I801 adapter at e800' as minor 0
Jan 21 12:44:18 gpserver kernel: i2c-proc.o version 2.8.2 (20031211)
Jan 21 12:44:24 gpserver kernel: asb100.o version 2.8.2 (20031211)
