From: christophe.dr@free.fr (christophe)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <200502152359.36555.christophe.dr@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le lundi 14 F?vrier 2005 20:17, Jean Delvare a ?crit?:
> Hi Christophe,
> > > We'd now need the output of "lspci -s 00:00.0 -vn" to add the quirk
> > > your system needs. With that I can write a patch for you to test (if
> > > you can do that).
> > Here you are :
> > lspci -s 00:00.0 -vn
> > 00:00.0 Class 0600: 8086:3340 (rev 21)
> >         Subsystem: 1043:184b
> >         Flags: bus master, fast devsel, latency 0
> >         Memory at e0000000 (32-bit, prefetchable) [size%6M]
> >         Capabilities: [e4] #09 [4104]
> >         Capabilities: [a0] AGP version 2.0
> OK, attached is a patch for Linux 2.6.10, which should do the trick. It
> should apply cleanly to any 2.6.11-rc version as well. (If you need it
> against an older kernel, just ask.)
Ok i didn't want to change my kernel 2.6.8.1-24mdk because i made many 
improvements on it (regarding dothan cpu and lirc). So i applied the patch 
you gave me on the /drivers/pci/quirks.c file. At the same place i just added 
the line about the w1n laptop :
		if (dev->device = PCI_DEVICE_ID_INTEL_82855PM_HB)
 			switch (dev->subsystem_device) {
+			case 0x184b: /* W1N notebook */
 			case 0x186a: /* M6Ne notebook */
 				asus_hides_smbus = 1;
 			}
Then i recompiled. (make mrproper, make all, make modules_install install)
Then... Nothing. Perhaps, there is something i forgot.
I don't understand. And i am not very good at kernel stuff. Everything about 
pci is activated in the kernel config. PCI access mode is set to 'any', 
legacy /proc/cpi interface is set, pci device name database is set, isa 
support is set, eisa support is set with generic pci/eisa, eisa virtual root 
device, eisa device name database, and natsemi SCx200 is set.
Actually i think your patch is good but does not seem to be exploited since 
lspci -v still says that :
00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 21)
        Subsystem: Asustek Computer, Inc.: Unknown device 184b    <---- Here
        Flags: bus master, fast devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size%6M]
        Capabilities: [e4] #09 [4104]
        Capabilities: [a0] AGP version 2.0
the device is unknown... I don't know how to tell the kernel to take your 
patch into account.
> If you confirm that the SMBus is properly un-hidden with that patch and
> no trouble arise, I'll push it to the PCI folks.
i'm sorry i could not make it work.
> > Peut-?tre parlez-vous (parles-tu) fran?ais ? Maybe you speak french ?
> He oui :) Mais ce n'est pas le cas de la majorit? des lecteurs de cette
> liste.
Let's speak globish... ;o)
