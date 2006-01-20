From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 20 Jan 2006 08:25:54 +0000
Subject: [lm-sensors] Call for 2.10.0
Message-Id: <20060120092554.7504bb08.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

It's about time to release a new version of lm_sensors, don't you
think? The CHANGES file lists a huge amount of changes since the
previous release, 4.5 months ago.

I propose that this new version be not numbered 2.9.3, but rather
2.10.0. My motivations are, besides the huge changelog and in no
particular order, the new PEC implementation (which affects i2c as much
as, if not even more than, lm_sensors), the new dependency on libsysfs
for Linux 2.6 support, and the drop of EEPROM support from sensord and
from libsensors for Linux 2.6 users. There are also a new driver
(f71805f) and major cleanups and fixes to the Winbond drivers (w83792d
and w83627hf).

The above also implies a new release of i2c (which would unsurprisingly
be numbered 2.10.0). It should bring even more compatibility with Linux
2.4 than the 2.9 series had, thanks to Hideki Iwamoto, but the changes
are thin enough so that upgrading from i2c 2.9 to i2c 2.10 should be
effortless. As far as I can see, lm_sensors 2.10.0 wouldn't even need
i2c 2.10.0 (while OTOH older versions of lm_sensors won't work with i2c
2.10.0 due to the drop of some PEC defines).

The above also suggests a bump of middle digit in libsensors version.
This would be libsensors 3.1.0. I'm not very familiar with library
numbering, but I think I remember that the middle number should change
to notify minor compatibility changes. This is clearly the case here,
as we are adding a dependency.

Let's declare a CVS freeze before the end of the month (e.g. January
29th), then give CVS a good testing for a week or two, and schedule the
next release by the second week on February. Does it sound like
reasonable plan to everyone? If there are no objections, I'll make a
news item.

Thanks,
-- 
Jean Delvare

