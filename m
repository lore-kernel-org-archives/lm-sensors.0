From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: bug : mkdev.sh creates devices that sensors-detect cannot use
Message-Id: <200407151200.i6FC0bFT041993@zone3.gcu-squad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040708184144.4554439e@pegasus.ucs.co.za>
In-Reply-To: <20040708184144.4554439e@pegasus.ucs.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>No, the kernel version is 2.4.18. The machine I installed lm_sensors on
>is unavailable atm, so I can't check whether or not acpi is being used.
>However, a similar machine's dmesg reveals :
>
>Linux version 2.4.18 (root@bob.bob.co.za) (gcc version 2.96 20000731
>(Red Hat Linux 7.1 2.96-85)) #4 SMP Thu May 16 00:39:32 SAST 2002
>BIOS-provided physical RAM map:
>BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>BIOS-e820: 000000000009fc00 - 00000000000a0000(reserved)
>BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>BIOS-e820: 0000000000100000 - 000000000f7fc000 (usable)
>BIOS-e820: 000000000f7fc000 - 000000000f7ff000 (ACPI data)
>BIOS-e820: 000000000f7ff000 - 000000000f800000 (ACPI NVS)
>BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
>
>Dunno if this means acpi is being used or not, as there are no other
>entries in dmesg containing this string.

Unless heavily patched, a 2.4.18 kernel couldn't have support for ACPI,
as it wasn't even part of the kernel tree back then. When there, the
ACPI supports shouts much more than that anyway ;)

Do you have similar results on this second machine as with the original
one, or did you just not try lm_sensors (yet)?

Could you please provide the contents of /proc/ioports for this similar
machine (or the original one if you ever get access again)?

>Bear in mind though that even without devfs creating any new devices,
>sensors had enough to work from to give me the info I needed / expected
>to get ie CPU temp, fan RPMs etc.

I suspect that your hardware monitoring chip was found on the ISA bus (it
should show in the form *-isa-* in "sensors"), so your SMBus is
actually not used and most likely not working. I would of course
appreciate it if you could confirm that. Maybe you don't care (since it
seems to work fine) but that's still a problem we'll have to remember
of.

Anyway, with such a different version of the kernel, I have to admit that
your problem and mine are not related, at least not directly.

Thanks,
Jean Delvare
