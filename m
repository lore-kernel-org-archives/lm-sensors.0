From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Apr 2006 12:22:14 +0000
Subject: [lm-sensors] [PATCH 08/10] lm83: Documentation update
Message-Id: <20060425142214.1ff4b7b2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-lm83-documentation-update.patch

One more motherboard confirmed to have an LM83 temperature sensor chip.
Thanks to Steven Hardy for reporting.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/lm83 |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17-rc1.orig/Documentation/hwmon/lm83	2006-04-03 20:50:39.000000000 +0200
+++ linux-2.6.17-rc1/Documentation/hwmon/lm83	2006-04-05 18:58:06.000000000 +0200
@@ -35,6 +35,7 @@
 
 Confirmed motherboards:
     SBS         P014
+    SBS         PSL09
 
 Unconfirmed motherboards:
     Gigabyte    GA-8IK1100

-- 
Jean Delvare

