From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Ticket #1352
Message-Id: <20030804203815.12ba9b9d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F2E9EBB.3040600@fractalzone.be>
In-Reply-To: <3F2E9EBB.3040600@fractalzone.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> For the BIOS, I have is the latest version. Therefore, this is not
> the solution.

Wrong. You can have the latest BIOS and this BIOS can be dead broken.
Wouldn't be the first time, nor the last. It's especially possible on
recent hardware.

BTW, is there any monitoring information shown in the BIOS screens (boot
time and setup)?

> I also tried the new 2.6.0-test2 kernel and I got some improvements : 
> now it detects the SMBus but it says it is disabled.
> 
> Here is the output of lspci -vv:
> 
> 00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
>     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
>     ParErr- 
> Stepping- SERR- FastB2B-
>     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>     Interrupt: pin B routed to IRQ 10
>     Region 4: I/O ports at 1000 [disabled] [size2]
> 
> The IRQ is 10 which is the same as the Firewire and the CardBus 
> controllers. However, I didn't compile Firewire and CardBus in the 
> kernel. Therefore, I don't think it is an IRQ conflict.

It could be linked to ACPI. Linux ACPI support includes an alternative
IRQ routing system, which sometimes solves this kind of problems. If you
don't use ACPI yet, I think it could be a good time to give it a try.
  http://sourceforge.net/project/showfiles.php?group_id6832
Make sure you use the latest version. Note that real ACPI support
doesn't exist in Linux 2.4 before 2.4.22-pre4 or so.

Likewise, if you *do* use ACPI on your laptop, you could try disabling
it for a short time and test if lm_sensors then works, or pass some
parameter to your kernel that change how ACPI works:
  http://sdb.suse.de/en/sdb/html/81_acpi.html

I'm only guessing, maybe it won't help at all.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
