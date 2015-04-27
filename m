From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 27 Apr 2015 14:37:39 +0000
Subject: [lm-sensors] [PATCH] hwmon: Update the location of my quilt tree
Message-Id: <20150427163739.01a03a7c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This new location was supposed to be temporary, but a couple years
have elapsed and it's still there, so apparently it's there to stay.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
Guenter, can you pick this in your tree please? I don't have anything
else to send ATM.

 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-4.1-rc1.orig/MAINTAINERS	2015-04-27 16:24:51.445267115 +0200
+++ linux-4.1-rc1/MAINTAINERS	2015-04-27 16:33:57.946487307 +0200
@@ -4516,7 +4516,7 @@ M:	Jean Delvare <jdelvare@suse.de>
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	lm-sensors@lm-sensors.org
 W:	http://www.lm-sensors.org/
-T:	quilt kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/
+T:	quilt http://jdelvare.nerim.net/devel/linux/jdelvare-hwmon/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
 S:	Maintained
 F:	Documentation/hwmon/


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
