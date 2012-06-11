From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 11 Jun 2012 17:20:41 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Document TjMax for 3rd generation i5/i7 processors
Message-Id: <1339435241-11630-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Tjmax values from Intel datasheets.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/coretemp |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
index 651a7ab..5e3a3d1 100644
--- a/Documentation/hwmon/coretemp
+++ b/Documentation/hwmon/coretemp
@@ -54,6 +54,17 @@ Some information comes from ark.intel.com
 
 Process		Processor					TjMax(C)
 
+22nm		Core i5/i7 Processors
+		i7 3920XM, 3820QM, 3720QM, 3520M, 3667U		105
+		i5 3360M/3320M, 3427U				105
+		i7 3770/3770K					105
+		i5 3570/3570K, 3550, 3450/3470			105
+		i7 3770S					103
+		i5 3570S/3550S, 3475S/3470S/3450S		103
+		i7 3770T					94
+		i5 3570T					94
+		i5 3470T					91
+
 32nm		Core i3/i5/i7 Processors
 		i7 660UM/640/620, 640LM/620, 620M, 610E		105
 		i5 540UM/520/430, 540M/520/450/430		105
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
