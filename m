From: p.wautelet@fractalzone.be (Philippe Wautelet)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Ticket #1352
Message-Id: <3F2FEA19.7090602@fractalzone.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F2E9EBB.3040600@fractalzone.be>
In-Reply-To: <3F2E9EBB.3040600@fractalzone.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>BTW, is there any monitoring information shown in the BIOS screens (boot
>time and setup)?
>
There is nothing about that. The BIOS screen is very simple!

>It could be linked to ACPI. Linux ACPI support includes an alternative
>IRQ routing system, which sometimes solves this kind of problems. If you
>don't use ACPI yet, I think it could be a good time to give it a try.
>  http://sourceforge.net/project/showfiles.php?group_id6832
>Make sure you use the latest version. Note that real ACPI support
>doesn't exist in Linux 2.4 before 2.4.22-pre4 or so.
>
>Likewise, if you *do* use ACPI on your laptop, you could try disabling
>it for a short time and test if lm_sensors then works, or pass some
>parameter to your kernel that change how ACPI works:
>  http://sdb.suse.de/en/sdb/html/81_acpi.html
>
>I'm only guessing, maybe it won't help at all.
>

The 2.4.20 kernel I'm using is a vanilla kernel that I patched with 
ACPI. I have just tried various combinations of parameters (acpi=off, 
pci=noacpi and no parameters) but there are absolutely no differences 
for the 2.4.20 kernel. However, for the 2.6.0-test2, I got some when I 
use either acpi=off or pci=noacpi. dmesg gives:

PCI: IRQ 0 for device 0000:00:02.1 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:02.1
PCI: Sharing IRQ 10 with 0000:00:02.3
PCI: Sharing IRQ 10 with 0000:00:09.0

There is nothing new here (except the warning about PIRQ).
If I also use pci=usepirqmask, the warning message disappears. But this 
does not give any improvement on the sensor problem, it is still "disabled".

-- 
Philippe Wautelet
Research assistant,
Aerodynamics Group, University of Liege, Belgium, http://www.ulg.ac.be/aerodyn
Private website: http://www.fractalzone.be

