From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 01 Mar 2009 08:58:56 +0000
Subject: Re: [lm-sensors] Compaq Evo D51S hidden sensor
Message-Id: <20090301095856.0ba4ab52@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
In-Reply-To: <BLU145-W35B82847EBE241F19D2D21B8DC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Sun, 1 Mar 2009 17:14:15 +1000, David O'Shea wrote:
> 
> Hi Jean,
> 
> Apologies for my late reply too :)
> 
> > Date: Tue, 27 Jan 2009 10:44:00 +0100
> [...]
> > > The fact that it didn't work with the IDE could just be because I'm so
> > > clueless!  Does the fact that the IDE controller has a function number
> > > other than 0 affect the way the DECLARE_PCI_FIXUP_HEADER() macro is used
> > > or what is passed to the hook function?  Even if not, if you think using
> > > the IDE is preferable I can have another try in case it didn't work due
> > > to a stupid mistake.
> > 
> > Yes, I would like you to try again with the IDE device, because there's
> > only one IDE device and 3 USB devices so using the IDE device should be
> > more efficient (quirk runs only once.)
> 
> That makes sense!  Now that I look more closely, I guess the 3 USB devices each have their own ID, though, so it wouldn't be so bad:
> 
> 00:1d.0 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 [8086:24c2] (rev 01) (prog-if 00 [UHCI])
> 00:1d.1 USB Controller [0c03]: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 [8086:24c4] (rev 01) (prog-if 00 [UHCI])
> 00:1d.7 USB Controller [0c03]: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller [8086:24cd] (rev 01) (prog-if 20 [EHCI])
> 
> i.e. 24c2 would only pick up the first one.

Ah, good point. Then it should indeed be OK to use one of the USB
controllers ID.

> 
> > No, the function number shouldn't play any role. I can't see any reason
> > why IDE wouldn't work.
> 
> I tried again and I guess it is an ordering issue - the special bit has to be set in the ISA bridge which is at 00:1f.0 but the IDE controller is at 00:1f.1 so the function that sets 'asus_hides_smbus' is called after the function that checks it.  I used '#define DEBUG 1' and 'dmesg' to verify:
> 
> >>>
> pci 0000:00:1f.0: calling acpi_pm_check_graylist+0x0/0x2d
> * The chipset may have PM-Timer Bug. Due to workarounds for a bug,
> * this clock source is slow. If you are sure your timer does not have
> * this bug, please use "acpi_pm_good" to disable the workaround
> pci 0000:00:1f.0: calling old_ich_force_enable_hpet_user+0x0/0x20
> HPET not enabled in BIOS. You might try hpet=force boot option
> pci 0000:00:1f.0: calling asus_hides_smbus_lpc+0x0/0xa6
> pci 0000:00:1f.0: calling quirk_ich4_lpc_acpi+0x0/0x65
> pci 0000:00:1f.0: quirk: region f800-f87f claimed by ICH4 ACPI/GPIO/TCO
> pci 0000:00:1f.0: quirk: region fa00-fa3f claimed by ICH4 GPIO
> pci 0000:00:1f.0: calling pci_fixup_transparent_bridge+0x0/0x2b
> PCI: 0000:00:1f.1 reg 10 io port: [24b0, 24b7]
> PCI: 0000:00:1f.1 reg 14 io port: [24c0, 24c3]
> PCI: 0000:00:1f.1 reg 18 io port: [24b8, 24bf]
> PCI: 0000:00:1f.1 reg 1c io port: [24c4, 24c7]
> PCI: 0000:00:1f.1 reg 20 io port: [24a0, 24af]
> PCI: 0000:00:1f.1 reg 24 32bit mmio: [0, 3ff]
> pci 0000:00:1f.1: calling asus_hides_smbus_hostbridge+0x0/0x22e
> pci 0000:00:1f.1: quirk: FIXME: FOUND IDE, THIS IS A COMPAQ EVO, SETTING asus_hides_smbus = 1
> pci 0000:00:1f.1: calling pci_fixup_transparent_bridge+0x0/0x2b
> <<<
> 
> asus_hides_smbus_lpc() is of course the function that checks 'asus_hides_smbus' and you can see it is called before we got to the point where it was set.

You are correct.

> 
> As you can see from earlier in the mail, the USB controllers are at 00:1d so they come before the ISA bridge and I guess that's why using one of them worked for me!  Given that they each have their own ID would it be okay to use them then?

Did you try using DECLARE_PCI_FIXUP_EARLY() instead of
DECLARE_PCI_FIXUP_HEADER()? I suspect this would let you use the IDE
controller.

But as said above, I am now also fine with you using one of the USB
controllers if you prefer; it's up to you. When you have a working
patch, please send it to me and I'll review it quickly so that it can
make it into 2.6.30.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
