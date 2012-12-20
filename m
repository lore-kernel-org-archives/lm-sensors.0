From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 20 Dec 2012 06:29:34 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (coretemp) Document and add support for additional CPU models
Message-Id: <1355984976-1033-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/coretemp |    9 +++++++++
 drivers/hwmon/coretemp.c     |    5 +++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
index 3374c08..fec5a9b 100644
--- a/Documentation/hwmon/coretemp
+++ b/Documentation/hwmon/coretemp
@@ -66,6 +66,7 @@ Process		Processor					TjMax(C)
 		i5 3470T					91
 
 32nm		Core i3/i5/i7 Processors
+		i7 2600						98
 		i7 660UM/640/620, 640LM/620, 620M, 610E		105
 		i5 540UM/520/430, 540M/520/450/430		105
 		i3 330E, 370M/350/330				90 rPGA, 105 BGA
@@ -79,7 +80,10 @@ Process		Processor					TjMax(C)
 		P4505/P4500 					90
 
 32nm		Atom Processors
+		S1260/1220					95
+		S1240						102
 		Z2460						90
+		Z2760						90
 		D2700/2550/2500					100
 		N2850/2800/2650/2600				100
 
@@ -98,6 +102,7 @@ Process		Processor					TjMax(C)
 
 45nm		Atom Processors
 		D525/510/425/410				100
+		K525/510/425/410				100
 		Z670/650					90
 		Z560/550/540/530P/530/520PT/520/515/510PT/510P	90
 		Z510/500					90
@@ -107,7 +112,11 @@ Process		Processor					TjMax(C)
 		330/230						125
 		E680/660/640/620				90
 		E680T/660T/640T/620T				110
+		E665C/645C					90
+		E665CT/645CT					110
 		CE4170/4150/4110				110
+		CE4200 series					unknown
+		CE5300 series					unknown
 
 45nm		Core2 Processors
 		Solo ULV SU3500/3300				100
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index d64923d..3f1e297 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -198,7 +198,7 @@ struct tjmax {
 static const struct tjmax __cpuinitconst tjmax_table[] = {
 	{ "CPU  230", 100000 },		/* Model 0x1c, stepping 2	*/
 	{ "CPU  330", 125000 },		/* Model 0x1c, stepping 2	*/
-	{ "CPU CE4110", 110000 },	/* Model 0x1c, stepping 10	*/
+	{ "CPU CE4110", 110000 },	/* Model 0x1c, stepping 10 Sodaville */
 	{ "CPU CE4150", 110000 },	/* Model 0x1c, stepping 10	*/
 	{ "CPU CE4170", 110000 },	/* Model 0x1c, stepping 10	*/
 };
@@ -212,7 +212,7 @@ struct tjmax_model {
 #define ANY 0xff
 
 static const struct tjmax_model __cpuinitconst tjmax_model_table[] = {
-	{ 0x1c, 10, 100000 },	/* D4xx, N4xx, D5xx, N5xx */
+	{ 0x1c, 10, 100000 },	/* D4xx, K4xx, N4xx, D5xx, K5xx, N5xx */
 	{ 0x1c, ANY, 90000 },	/* Z5xx, N2xx, possibly others
 				 * Note: Also matches 230 and 330,
 				 * which are covered by tjmax_table
@@ -222,6 +222,7 @@ static const struct tjmax_model __cpuinitconst tjmax_model_table[] = {
 				 * is undetectable by software
 				 */
 	{ 0x27, ANY, 90000 },	/* Atom Medfield (Z2460) */
+	{ 0x35, ANY, 90000 },	/* Atom Clover Trail/Cloverview (Z2760) */
 	{ 0x36, ANY, 100000 },	/* Atom Cedar Trail/Cedarview (N2xxx, D2xxx) */
 };
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
