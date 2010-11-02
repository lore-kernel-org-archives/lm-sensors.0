From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 02 Nov 2010 16:42:21 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: Schedule the removal of the old
Message-Id: <20101102174221.2e2cbcff@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/feature-removal-schedule.txt |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- linux-2.6.37-rc1.orig/Documentation/feature-removal-schedule.txt	2010-11-02 09:19:34.000000000 +0100
+++ linux-2.6.37-rc1/Documentation/feature-removal-schedule.txt	2010-11-02 17:36:06.000000000 +0100
@@ -554,3 +554,13 @@ Why:    This is a legacy interface which
 Who:    NeilBrown <neilb@suse.de>
 
 ----------------------------
+
+What:	Legacy, non-standard chassis intrusion detection interface.
+When:	June 2011
+Why:	The adm9240, w83792d and w83793 hardware monitoring drivers have
+	legacy interfaces for chassis intrusion detection. A standard
+	interface has been added to each driver, so the legacy interfaces
+	can be removed.
+Who:	Jean Delvare <khali@linux-fr.org>
+
+----------------------------


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
