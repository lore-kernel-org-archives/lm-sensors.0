From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 23 Apr 2014 17:27:03 +0000
Subject: [lm-sensors] [PATCH 0/2] Versatile Express hwmon driver fixes
Message-Id: <1398274025-13618-1-git-send-email-pawel.moll@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

Here comes a short series of fixes to the vexpress hwmon driver,
as requested by Guenter. I'm not 100% sure whether it's worth
copying stable with those, but they seem to be a good candidate
for 3.15-rc3...

Cheers!

Pawel


Pawel Moll (2):
  hwmon: vexpress: Use legal hwmon device names
  hwmon: vexpress: Avoid creating non-existing attributes

 drivers/hwmon/vexpress.c | 83 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 71 insertions(+), 12 deletions(-)

-- 
1.8.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
