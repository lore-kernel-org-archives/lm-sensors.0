From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: winbond temp magnitudes 2.6.1-rc1
Message-Id: <4004AEFE.2030605@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The w83781d and friends temperature magnitudes, that were 2 in -test9,
are now even more whacked in -rc1.
temp_xxx1 is still 2; temp_xxx2 and temp_xxx3 are now 1.
I thought we were going for a magnitude of 3 everywhere?!?!?!

Can anybody else verify?

Assuming 2.6.1 is the same, we'll either have to fix lib/chips.c to match
or else submit a new kernel patch and wait for it to get applied before releasing.

mds
