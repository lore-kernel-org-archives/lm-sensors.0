From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 09 Oct 2012 21:09:03 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (coretemp) Add support for Atom CE4110/4150/4170
Message-Id: <1349816943-17697-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

TjMax for the CE4100 series of Atom CPUs was previously reported to be
110 degrees C.

cpuinfo logs on the web show existing CPU types CE4110, CE4150, and CE4170,
reported as "model name : Intel(R) Atom(TM) CPU CE41{1|5|7}0 @ 1.{2|6}0GHz"
with model 28 (0x1c) and stepping 10 (0x0a). Add the three known variants
to the tjmax table.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/coretemp |    1 +
 drivers/hwmon/coretemp.c     |    7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
index 0cc4050..e36960a 100644
--- a/Documentation/hwmon/coretemp
+++ b/Documentation/hwmon/coretemp
@@ -107,6 +107,7 @@ Process		Processor					TjMax(C)
 		330/230						125
 		E680/660/640/620				90
 		E680T/660T/640T/620T				110
+		CE4110/4150/4170				110
 
 45nm		Core2 Processors
 		Solo ULV SU3500/3300				100
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 96ab10c..f6ff76c 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -196,8 +196,11 @@ struct tjmax {
 };
 
 static const struct tjmax __cpuinitconst tjmax_table[] = {
-	{ "CPU  230", 100000 },
-	{ "CPU  330", 125000 },
+	{ "CPU  230", 100000 },		/* Model 0x1c, stepping 2	*/
+	{ "CPU  330", 125000 },		/* Model 0x1c, stepping 2	*/
+	{ "CPU CE4110", 110000 },	/* Model 0x1c, stepping 10	*/
+	{ "CPU CE4150", 110000 },	/* Model 0x1c, stepping 10	*/
+	{ "CPU CE4170", 110000 },	/* Model 0x1c, stepping 10	*/
 };
 
 struct tjmax_model {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
