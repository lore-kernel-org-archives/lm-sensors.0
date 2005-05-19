From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Ticket #1352
Message-Id: <20030805204622.32659912.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F2E9EBB.3040600@fractalzone.be>
In-Reply-To: <3F2E9EBB.3040600@fractalzone.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> >BTW, is there any monitoring information shown in the BIOS screens
> >(boot time and setup)?
>
> There is nothing about that. The BIOS screen is very simple!

And, if you have another OS on the machine, do you have any hardware
monitoring working there?

> The 2.4.20 kernel I'm using is a vanilla kernel that I patched with 
> ACPI. I have just tried various combinations of parameters (acpi=off, 
> pci=noacpi and no parameters) but there are absolutely no differences 
> for the 2.4.20 kernel.

Using 2.4.21 or even 2.4.22-preX with a recent ACPI patch would probably
make it behave as 2.6.0-testX does.

> However, for the 2.6.0-test2, I got some when I
> use either acpi=off or pci=noacpi. dmesg gives:
> 
> PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try 
> pci=usepirqmask
> PCI: Found IRQ 10 for device 0000:00:02.1
> PCI: Sharing IRQ 10 with 0000:00:02.3
> PCI: Sharing IRQ 10 with 0000:00:09.0
> 
> There is nothing new here (except the warning about PIRQ).
> If I also use pci=usepirqmask, the warning message disappears. But
> this does not give any improvement on the sensor problem, it is still
> "disabled".

00:02.1 being the SMBus device, I suspect all these is related.
Obviously, your BIOS manufacturer did not allocate an IRQ for the device
if ACPI isn't used, and did not allocate an adequate I/O space, if I
followed your discussion with Mark M. Hoffman correctly. I suspect they
just don't want you to use the device yet. As you say in your other
mail, a newer BIOS may help someday.

Maybe you should contact Packard-Bell and ask them about it?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
