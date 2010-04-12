From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Mon, 12 Apr 2010 13:27:48 +0000
Subject: [lm-sensors] [PATCH] hwmon: Switch applesmc maintainer
Message-Id: <1271078868-3699-1-git-send-email-rydberg@euromail.se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: nicolas@boichat.ch, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Nicolas has expressed a wish to be relieved from the maintenance
of applesmc, so we simply switch maintainer with this patch.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a9ccda..13c5688 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -485,8 +485,8 @@ S:	Maintained
 F:	drivers/input/mouse/bcm5974.c
 
 APPLE SMC DRIVER
-M:	Nicolas Boichat <nicolas@boichat.ch>
-L:	mactel-linux-devel@lists.sourceforge.net
+M:	Henrik Rydberg <rydberg@euromail.se>
+L:	lm-sensors@lm-sensors.org
 S:	Maintained
 F:	drivers/hwmon/applesmc.c
 
-- 
1.6.3.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
