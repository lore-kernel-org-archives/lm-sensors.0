From: ebay2@deconfusion.org (Paul Grayson)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: Ticket #: 1368 - could lm_sensors have affected my ability to power
Message-Id: <43d6eukbfw.fsf@pup.phpwebhosting.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It's possible that lm_sensors is reponsible for that, because we have
> been writing the driver for you chipset without a datasheet (blame
> Asus for that).  Maybe using the init=0 parameter for the w83781d
> module will help (unless the value that might have been broken by our
> initialization is not reset at boot time, in which case you're
> doomed).

Then my a7v333 motherbord is doomed, as I can't even power off during
the first phase of boot, when the bios does its tests.  That's pretty
disappointing!

If anyone knows about how to undo the damage, for example by resetting
the chips to their pre-lm_sensors state, please let me know.

Also, can anyone suggest what I could possibly say to ASUS when asking
them for help with the problem?

-Paul
