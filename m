From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Apr 2007 13:02:27 +0000
Subject: [lm-sensors] Hardware monitoring subsystem maintainer position is
Message-Id: <20070410150227.1bac05b5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I am resigning from my role as hardware monitoring subsystem
(drivers/hwmon) maintainer. This is too much work for me, I do not have
the necessary bandwidth to review all the incoming patches, in
particular new drivers, in a timely manner. Patch authors have been
complaining about this repeatedly. This is no fun for them, and even
less for me, so I'd rather let someone else with more spare time take
care of it. If there are volunteers, this is the right time to speak up.

I will still be maintaining the individual hardware monitoring drivers
I am listed for in file MAINTAINERS (adm1025, f71805f, lm83 and lm90)
as well as the I2C subsystem. No change here.

I will continue to feed -mm with pending hwmon patches until 2.6.21
final is released, then I'll send everything I have to Linus for
2.6.22-rc1, the last of which will be:

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 MAINTAINERS |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- linux-2.6.21-rc6.orig/MAINTAINERS	2007-04-10 13:49:09.000000000 +0200
+++ linux-2.6.21-rc6/MAINTAINERS	2007-04-10 14:28:31.000000000 +0200
@@ -1467,12 +1467,9 @@ W:	http://gigaset307x.sourceforge.net/
 S:	Maintained
 
 HARDWARE MONITORING
-P:	Jean Delvare
-M:	khali@linux-fr.org
 L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.org/
-T:	quilt http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/
-S:	Maintained
+S:	Orphan
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
 P:	Michael Buesch

Then I'll probably keep an eye on hwmon in Linus' tree until 2.6.22
final is released, and after that I'm done with it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
