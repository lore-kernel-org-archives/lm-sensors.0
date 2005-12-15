From: hidden@paradise.net.nz (Volker Kuhlmann)
Date: Thu, 15 Dec 2005 19:25:01 +0000
Subject: [lm-sensors] lm_sensors and nvidia graphic card temperature
Message-Id: <20051215192501.GA6582@ruru.site>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399BE92.9020705@mathematica.scientia.net>
In-Reply-To: <4399BE92.9020705@mathematica.scientia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> If you have a recent graphics adapter, you most likely need the
> nvidiafb driver. Just because rivafb loads silently doesn't mean it did
> anything useful. Actually, the fact that it was silent suggests very
> strongly that it does NOT support your graphics adapter.

Thanks, that makes sense. Loading nvidiafb gives in syslog

kernel: nvidiafb: module not supported by Novell, setting U taint flag.
kernel: ACPI: PCI Interrupt 0000:05:00.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 58
kernel: PCI: Unable to reserve mem region #2:10000000 at e0000000 for device 0000:05:00.0
kernel: nvidiafb: cannot request PCI regions
kernel: ACPI: PCI interrupt for device 0000:05:00.0 disabled
kernel: klogd 1.4.1, ---------- state change ----------

Which doesn't look too good to me, and sensors-detect doesn't find
anything more. From lspci

05:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600] (rev a2)

There was something about this on this list in March, but that involved
kernel oopses.

At least the display doesn't crash and burn on me... Everything seems to
continue to operate normally.

Linux  2.6.13-15.7-default #1 Tue Nov 29 14:32:29 UTC 2005 x86_64 x86_64 x86_64 GNU/Linux

Booting with acpi=off at the grub command line leads to a stone dead
system before I've lifted the finger off the enter key.

# i2cdetect -l
i2c-2   dummy   ISA main adapter                ISA bus algorithm
i2c-1   unknown SMBus nForce2 adapter at 1c40   Algorithm unavailable
i2c-0   unknown SMBus nForce2 adapter at 1c00   Algorithm unavailable

These are already accounted for (mobo super io, 2 dimms).

I'm so far running with xorg's nv driver, though I could try nvidia's.

Thanks + greets,

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

