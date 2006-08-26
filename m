From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Aug 2006 21:28:24 +0000
Subject: [lm-sensors] Using ... SMSC EMC6W201
Message-Id: <20060826232824.91a142b6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
In-Reply-To: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ric,

> On the subject of using an existing driver, quite a while back I looked
> hard for options to use. All fell short but the fscscy.c driver for the
> Fujitsu-Siemens Scylla chip looked promising. Alas there was no kernel
> module for it so I could not test it. ( I never found out why fscscy.o
> is MIA... ) The /usr/share/doc/packages/sensors/chips/fscscy does
> exist.

This is an old driver, for an old and rare chip. Nobody took the time
to port the driver to Linux 2.6, which is why you can't find it. The
chip drivers documentation in the lm_sensors package is for the Linux
2.4 drivers and should not be installed on a Linux 2.6-based system.

I would be very surprised if a Scylla chip was used in a recent system.
And I very much doubt any other chip would be even slightly compatible
with it. So my advice would be: forget about fscscy, it's not going to
help you.

> The point of this being that there are 3 more fans that the IT8712F can
> monitor, according to the datasheet, but it appears that the 8712F
> driver does not have those other 3 fans. If so, is there anybody
> working on upgrading that driver? 

The latest revisions of the IT8712F can support 5 fans instead of 3.
This is 2 more fans, not 3. Our driver doesn't support them for now,
but it could be added if enough users show interest.

-- 
Jean Delvare

