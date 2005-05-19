From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <PmnF0A25.1108544781.6308140.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Christophe,

> Ok i didn't want to change my kernel 2.6.8.1-24mdk because i made many
> improvements on it (regarding dothan cpu and lirc). So i applied the patch
> you gave me on the /drivers/pci/quirks.c file. At the same place i just
> added the line about the w1n laptop :
>		if (dev->device = PCI_DEVICE_ID_INTEL_82855PM_HB)
> 			switch (dev->subsystem_device) {
>+			case 0x184b: /* W1N notebook */
> 			case 0x186a: /* M6Ne notebook */
> 				asus_hides_smbus = 1;
> 			}
> Then i recompiled. (make mrproper, make all, make modules_install install)
> Then... Nothing. Perhaps, there is something i forgot.

The expected effect was that lspci should now list a 00:0f.3 device. If
it doesn't, then the quirk failed, right.

> I don't understand. And i am not very good at kernel stuff. Everything
> about pci is activated in the kernel config. PCI access mode is set to
> 'any', legacy /proc/cpi interface is set, pci device name database is set,
> isa support is set, eisa support is set with generic pci/eisa, eisa
> virtual root device, eisa device name database, and natsemi SCx200 is set.

Have you enabled hotplug support (and possibly explicitely PCI hotplug
support)? These was needed for the 2.4 quirks, so I'd expect it to be
required in 2.6 too.

> Actually i think your patch is good but does not seem to be exploited since
> lspci -v still says that :
>00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
>        Subsystem: Asustek Computer, Inc.: Unknown device 184b    <---- Here
>        Flags: bus master, fast devsel, latency 0
>        Memory at e0000000 (32-bit, prefetchable) [size%6M]
>        Capabilities: [e4] #09 [4104]
>        Capabilities: [a0] AGP version 2.0
> the device is unknown... I don't know how to tell the kernel to take your
> patch into account.

The patch is not supposed to make the device appear as non-unknown.
Devices are unknown when they are not listed in /usr/share/pci.ids
(and/or the in-kernel equivalent). It just means we have no string that
names the device. The device is still active.

The 00:00.0 PCI device is just used as an identification mean. Don't
expect any change on it with the patch.

Are you sure you added the code chunk in the Asus part of the function,
and not in the HP part?

You might also try with a 2.6.10 kernel and my original patch, even if it
is only temporary. If that works then at least we'll know that the
quirk is correct and 2.6.8.1 simply lacks something (supposedly).

--
Jean Delvare
