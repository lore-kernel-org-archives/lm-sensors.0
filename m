From: dynmail1@gassner-waagen.at (Michael Burian)
Date: Thu, 23 Feb 2006 12:49:21 +0000
Subject: [lm-sensors] Bug in initialisation of stopped RTC's in ds1337.c
Message-Id: <43FDAF51.50207@gassner-waagen.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The current initialisation code for handling the "RTC not running" case
is buggy. Overwritting the whole 16 regs with zero turned out to be a
bad idea.

This was hard to track down, as initscripts used to overwrite that
invalid date with a valid one and that date was written back to the RTC
on shutdown - everything looked fine.

Recently a fsck caused an immediate reboot so initscripts had no chance
to fix this. Afterwards the probing failed (because of the invalid date)
and I ended up with the problems described in the previous mail.

The attached patch can be applied against mainline and should fix the
problem by detecting if the RTC is not running, changing 2 bits (OSF,
EOSC) as necessary, and no longer overwriting the whole 16 regs.

Please review, thanks
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-Improve-initialisation-of-stopped-RTC.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060223/e34e9ca0/0001-Improve-initialisation-of-stopped-RTC.txt
