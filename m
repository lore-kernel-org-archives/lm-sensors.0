From: swl@ucs.co.za (stu)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: bug : mkdev.sh creates devices that sensors-detect cannot use
Message-Id: <20040715133058.41373a5c@pegasus.ucs.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040708184144.4554439e@pegasus.ucs.co.za>
In-Reply-To: <20040708184144.4554439e@pegasus.ucs.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 11 Jul 2004 20:48:10 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > >When I insmod i2c-viapro, devfs doesn't create any new devices.
> 
> Just had a similar problem today, with the same driver (i2c-viapro).
> Are you by any chance using any of 2.6.7-mm3, -mm5, -mm6 or -mm7 as
> your kernel, and are using ACPI?

No, the kernel version is 2.4.18. The machine I installed lm_sensors on
is unavailable atm, so I can't check whether or not acpi is being used.
However, a similar machine's dmesg reveals :

Linux version 2.4.18 (root@bob.bob.co.za) (gcc version 2.96 20000731
(Red Hat Linux 7.1 2.96-85)) #4 SMP Thu May 16 00:39:32 SAST 2002
BIOS-provided physical RAM map: 
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable) 
BIOS-e820: 000000000009fc00 - 00000000000a0000(reserved) 
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved) 
BIOS-e820: 0000000000100000 - 000000000f7fc000 (usable) 
BIOS-e820: 000000000f7fc000 - 000000000f7ff000 (ACPI data) 
BIOS-e820: 000000000f7ff000 - 000000000f800000 (ACPI NVS) 
BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)

Dunno if this means acpi is being used or not, as there are no other
entries in dmesg containing this string.

Bear in mind though that even without devfs creating any new devices,
sensors had enough to work from to give me the info I needed / expected
to get ie CPU temp, fan RPMs etc.

- -- 
Stuart Logie
Programmer

UNIVERSAL COMPUTER SERVICES (PTY) LTD
   
Powered by Debian GNU/Linux
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQCVAwUBQPZq8uuEbVzzghHCAQIDJgP/Uf8klbFAD8bmuSndDeii2Bgb2u/SLJgO
R7URurwGvwRHCTrJGFa3qWmeq/JX6B9MvxdV+fXrLT3hiT6bT8xXzrSL+ZlQMrgq
5bFJBC+X67Ilahzi1Tj1T6bFqfXJeAgANo8mCyiLPoP/A7h6nYa4NhQPRPyHQH2u
nPh6s+E+rW8=W8e3
-----END PGP SIGNATURE-----
