From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: chip initializations in 2.6
Message-Id: <1074763641.400f97791cfeb@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <400F2F25.1080909@verizon.net>
In-Reply-To: <400F2F25.1080909@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> anybody working on a patch to remove limit initializations by chip
> drivers in 2.6?

I think I remember MMH was planing to work on this, but I don't know how
far he went.

Note that some drivers were committed without limit initializations
(asb100.c, lm85.c, lm90.c, w83l785ts.c, eeprom.c) and others were
already fixed (lm75.c, lm83.c and w83781d.c). So this leaves a short
list of drivers that need to be fixed:
adm1021.c
it87.c
lm78.c
via686a.c

A few more thoughts:
1* Recent and less recent changes to the it87 driver in CVS should be
ported to 2.6 as well.
2* I would remove much more than just limits initializations from the
drivers, considering the number of reported problems that could be
solved with init=0. I remember proposing a common policy for all
drivers, must be somewhere in the mailing list archive, although I
can't find it at the moment. I think I suggested that only the minimal
init commands would be issued by default (init=1), they could be
disabled with init=0, or we could reset the chip and reconfigure it
completely with init=2.

Aha, post is here:
http://archives.andrew.net.au/lm-sensors/msg04593.html
(here I talk about a third value for limits, but I guess this is now off
topic).

Comments welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
