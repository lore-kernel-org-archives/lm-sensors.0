From: ericb@aspsys.com (Eric J. Bowersox)
Date: Tue, 02 Aug 2005 07:58:42 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, second try
Message-Id: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, after having received preliminary feedback, and also reading some of
the stuff I should have read in the first place, I have generated a
revised patch (attached).  Notable changes this time around:

(1) This is against 2.6.13-rc3-mm3.  The driver is in the "hwmon"
subdirectory, as it should be.
(2) Since the separate header file issue wasn't as gnarly as I thought
it might be, I left it broken out this time, as per Mark's wishes.
(3) I have applied sysfs attributes whereever they make sense to do so,
and have registered the class device as per Rudolf's suggested changes.
(4) The included documentation file is Mark's original as found in
lm_sensors 2.9.1, with some changes to reflect use of sysfs vs. /proc.
(5) I put the driver ID in the right place (i2c-id.h).

I haven't tested this particular code yet, but that will happen shortly,
once our production engineers find me an X6DHP box to tinker with.

Signed-off-by: Eric J. Bowersox <ericb@aspsys.com>

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm93-driver-2.6.13-rc3-mm3.patch
Type: text/x-patch
Size: 96495 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050802/87c8c264/lm93-driver-2.6.13-rc3-mm3-0001.bin
