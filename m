From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 10 Oct 2005 10:07:00 +0000
Subject: [lm-sensors] decode-dimms.pl updated for kernel 2.6
Message-Id: <zAF3yAGd.1128930953.9827070.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <45257.71.129.198.222.1128906245.squirrel@71.129.198.222>
In-Reply-To: <45257.71.129.198.222.1128906245.squirrel@71.129.198.222>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Eric,

> I've modified decode-dimms.pl to work on kernel 2.6 using /sys/bus/i2c
> in place of /proc/sys/dev/sensors.  I tried to preserve the ability to
> work with /proc, but I don't have a system running an old kernel to
> test it on. I've tested the new code on a Tyan S2892 motherboard
> running Fedora Core 4 with kernel-2.6.13-1.1526_FC4.

Well, the decode-dimms.pl script already supports sysfs, since July 15th
this year. lm_sensors 2.9.2 has it. What's wrong with it?

--
Jean Delvare
