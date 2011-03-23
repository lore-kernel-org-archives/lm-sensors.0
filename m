From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Mar 2011 20:47:02 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (f71882fg) Secure chip property
Message-Id: <20110323214702.69fa03ac@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Using C99-style array initialization will ensure definitions won't
drift if the chips enum gets new values added.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |   48 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

--- linux-2.6.39-rc0.orig/drivers/hwmon/f71882fg.c	2011-03-23 10:34:23.000000000 +0100
+++ linux-2.6.39-rc0/drivers/hwmon/f71882fg.c	2011-03-23 14:53:29.000000000 +0100
@@ -120,36 +120,36 @@ static const char *f71882fg_names[] = {
 };
 
 static const char f71882fg_has_in[8][F71882FG_MAX_INS] = {
-	{ 1, 1, 1, 1, 1, 1, 0, 1, 1 }, /* f71808e */
-	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f71858fg */
-	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71862fg */
-	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71869 */
-	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71882fg */
-	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71889fg */
-	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71889ed */
-	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f8000 */
+	[f71808e]	= { 1, 1, 1, 1, 1, 1, 0, 1, 1 },
+	[f71858fg]	= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
+	[f71862fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
+	[f71869]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
+	[f71882fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
+	[f71889fg]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
+	[f71889ed]	= { 1, 1, 1, 1, 1, 1, 1, 1, 1 },
+	[f8000]		= { 1, 1, 1, 0, 0, 0, 0, 0, 0 },
 };
 
 static const char f71882fg_has_in1_alarm[8] = {
-	0, /* f71808e */
-	0, /* f71858fg */
-	0, /* f71862fg */
-	0, /* f71869 */
-	1, /* f71882fg */
-	1, /* f71889fg */
-	1, /* f71889ed */
-	0, /* f8000 */
+	[f71808e]	= 0,
+	[f71858fg]	= 0,
+	[f71862fg]	= 0,
+	[f71869]	= 0,
+	[f71882fg]	= 1,
+	[f71889fg]	= 1,
+	[f71889ed]	= 1,
+	[f8000]		= 0,
 };
 
 static const char f71882fg_has_beep[8] = {
-	0, /* f71808e */
-	0, /* f71858fg */
-	1, /* f71862fg */
-	1, /* f71869 */
-	1, /* f71882fg */
-	1, /* f71889fg */
-	1, /* f71889ed */
-	0, /* f8000 */
+	[f71808e]	= 0,
+	[f71858fg]	= 0,
+	[f71862fg]	= 1,
+	[f71869]	= 1,
+	[f71882fg]	= 1,
+	[f71889fg]	= 1,
+	[f71889ed]	= 1,
+	[f8000]		= 0,
 };
 
 static struct platform_device *f71882fg_pdev;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
