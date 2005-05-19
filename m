From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: SiS645 driver additions
Message-Id: <20030120002638.A8515@earth.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello SiS chipset users:

I added support for 648 and 962 in CVS.  To use this,
you'll need to first get the latest I2C code from CVS:
(near the bottom of the page)

http://www2.lm-sensors.nu/~lm78/download.html

Then of course get the latest lm_sensors2 from CVS also.

Sensors maintainers:

FYI: I tested this on my 645/961 vs. a recent RedHat 2.4.
Besides adding PCI ids, are there any other changes I
should make to accomodate Ky?sti's recent work?

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
