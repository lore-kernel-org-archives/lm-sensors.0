From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 05 Oct 2006 08:22:44 +0000
Subject: [lm-sensors] [PATCH] hdaps: Cleanup the DMI detection data
Message-Id: <20061005102244.3dd5b1ac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Move the DMI detection from .text to .data. We really don't want
that amount of data on the stack.

Also refactor the macros used to generate the detection data, the
vendor becomes a parameter.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/hdaps.c |   68 +++++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

--- linux-2.6.19-rc1.orig/drivers/hwmon/hdaps.c	2006-10-05 09:01:07.000000000 +0200
+++ linux-2.6.19-rc1/drivers/hwmon/hdaps.c	2006-10-05 09:07:59.000000000 +0200
@@ -477,74 +477,64 @@
 /* Module stuff */
 
 /* hdaps_dmi_match - found a match.  return one, short-circuiting the hunt. */
-static int hdaps_dmi_match(struct dmi_system_id *id)
+static int __init hdaps_dmi_match(struct dmi_system_id *id)
 {
 	printk(KERN_INFO "hdaps: %s detected.\n", id->ident);
 	return 1;
 }
 
 /* hdaps_dmi_match_invert - found an inverted match. */
-static int hdaps_dmi_match_invert(struct dmi_system_id *id)
+static int __init hdaps_dmi_match_invert(struct dmi_system_id *id)
 {
 	hdaps_invert = 1;
 	printk(KERN_INFO "hdaps: inverting axis readings.\n");
 	return hdaps_dmi_match(id);
 }
 
-#define HDAPS_DMI_MATCH_NORMAL(model)	{		\
-	.ident = "IBM " model,				\
+#define HDAPS_DMI_MATCH_NORMAL(vendor, model) {		\
+	.ident = vendor " " model,			\
 	.callback = hdaps_dmi_match,			\
 	.matches = {					\
-		DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),	\
+		DMI_MATCH(DMI_BOARD_VENDOR, vendor),	\
 		DMI_MATCH(DMI_PRODUCT_VERSION, model)	\
 	}						\
 }
 
-#define HDAPS_DMI_MATCH_INVERT(model)	{		\
-	.ident = "IBM " model,				\
+#define HDAPS_DMI_MATCH_INVERT(vendor, model) {		\
+	.ident = vendor " " model,			\
 	.callback = hdaps_dmi_match_invert,		\
 	.matches = {					\
-		DMI_MATCH(DMI_BOARD_VENDOR, "IBM"),	\
+		DMI_MATCH(DMI_BOARD_VENDOR, vendor),	\
 		DMI_MATCH(DMI_PRODUCT_VERSION, model)	\
 	}						\
 }
 
-#define HDAPS_DMI_MATCH_LENOVO(model)   {               \
-        .ident = "Lenovo " model,                       \
-        .callback = hdaps_dmi_match_invert,             \
-        .matches = {                                    \
-                DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),  \
-                DMI_MATCH(DMI_PRODUCT_VERSION, model)   \
-        }                                               \
-}
+/* Note that HDAPS_DMI_MATCH_NORMAL("ThinkPad T42") would match
+  "ThinkPad T42p", so the order of the entries matters */
+static struct dmi_system_id __initdata hdaps_whitelist[] = {
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad H"),
+	HDAPS_DMI_MATCH_INVERT("IBM", "ThinkPad R50p"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad R50"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad R51"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad R52"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad H"),	   /* R52 (1846AQG) */
+	HDAPS_DMI_MATCH_INVERT("IBM", "ThinkPad T41p"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad T41"),
+	HDAPS_DMI_MATCH_INVERT("IBM", "ThinkPad T42p"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad T42"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad T43"),
+	HDAPS_DMI_MATCH_INVERT("LENOVO", "ThinkPad T60"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad X40"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad X41"),
+	HDAPS_DMI_MATCH_INVERT("LENOVO", "ThinkPad X60"),
+	HDAPS_DMI_MATCH_NORMAL("IBM", "ThinkPad Z60m"),
+	{ .ident = NULL }
+};
 
 static int __init hdaps_init(void)
 {
 	int ret;
 
-	/* Note that HDAPS_DMI_MATCH_NORMAL("ThinkPad T42") would match
-	  "ThinkPad T42p", so the order of the entries matters */
-	struct dmi_system_id hdaps_whitelist[] = {
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),
-		HDAPS_DMI_MATCH_INVERT("ThinkPad R50p"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad R50"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad R51"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad R52"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),	 /* R52 (1846AQG) */
-		HDAPS_DMI_MATCH_INVERT("ThinkPad T41p"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad T41"),
-		HDAPS_DMI_MATCH_INVERT("ThinkPad T42p"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad T42"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad T43"),
-		HDAPS_DMI_MATCH_LENOVO("ThinkPad T60p"),
-		HDAPS_DMI_MATCH_LENOVO("ThinkPad T60"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad X40"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41"),
-		HDAPS_DMI_MATCH_LENOVO("ThinkPad X60"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad Z60m"),
-		{ .ident = NULL }
-	};
-
 	if (!dmi_check_system(hdaps_whitelist)) {
 		printk(KERN_WARNING "hdaps: supported laptop not found!\n");
 		ret = -ENODEV;


-- 
Jean Delvare

