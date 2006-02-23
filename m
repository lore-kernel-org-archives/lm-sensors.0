From: dynmail1@gassner-waagen.at (Michael Burian)
Date: Thu, 23 Feb 2006 08:34:13 +0000
Subject: [lm-sensors] Relax probing for ds1337.c
Message-Id: <43FD7385.8020304@gassner-waagen.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm using mainline drivers/i2c/chips/ds1337.c (Dallas RTC)
for an embedded ep93xx board. (ARM based)

Whenever I end up with an invalid date in the RTC,
(first time boot, backup battery power failure, ...)
I run into the following vicious circle:

Invalid date -> i2c driver probing fails -> RTC driver doesn't get
loaded, => no chance of setting a valid date with hwclock.

I've looked at the probing routines and found them to be quite picky,
especially when compared to other RTC drivers. The following patch
relaxes the checks a bit so that the driver gets loaded even if the
date in the RTC is invalid.

This should not lead to problems, because startup scripts usually
detect invalid date/time and use hwclock to set some bogus, but valid
date. (like 1st Jan 2002). Afterwards user/ntpdate/dcf77/gps can set a
valid date again.

I've already sent this to the author, but he asked me to have it
reviewed first.

Please tell me whether this changes are acceptable, or if there is a
better way.

Thanks
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-Relax-probing-to-prevent-catch22.txt
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060223/b1767ccd/0001-Relax-probing-to-prevent-catch22-0001.txt
