From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Apr 2006 12:20:11 +0000
Subject: [lm-sensors] [PATCH 06/10] hdaps: Update the list of supported
Message-Id: <20060425142011.6dbc8a14.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-hdaps-update-id-list.patch

Update the list of systems supported by the hdaps driver:
* Add the "ThinkPad Z60m" entry, reported by Arkadiusz Miskiewicz.
* Add the "ThinkPad H" entry, reported by Frank Gevaerts for some
  ThinkPad R52 models (1846AQG).
* Drop the "ThinkPad X41 Tablet" entry, which looks redundant to me.
And a comment update for good measure.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Arkadiusz Miskiewicz <arekm at maven.pl>
Cc: Frank Gevaerts <frank at gevaerts.be>
---
 drivers/hwmon/hdaps.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc1.orig/drivers/hwmon/hdaps.c	2006-04-11 23:13:47.000000000 +0200
+++ linux-2.6.17-rc1/drivers/hwmon/hdaps.c	2006-04-12 07:40:17.000000000 +0200
@@ -522,13 +522,15 @@
 {
 	int ret;
 
-	/* Note that DMI_MATCH(...,"ThinkPad T42") will match "ThinkPad T42p" */
+	/* Note that HDAPS_DMI_MATCH_NORMAL("ThinkPad T42") would match
+	  "ThinkPad T42p", so the order of the entries matters */
 	struct dmi_system_id hdaps_whitelist[] = {
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),
 		HDAPS_DMI_MATCH_INVERT("ThinkPad R50p"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R50"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R51"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad R52"),
+		HDAPS_DMI_MATCH_NORMAL("ThinkPad H"),	 /* R52 (1846AQG) */
 		HDAPS_DMI_MATCH_INVERT("ThinkPad T41p"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad T41"),
 		HDAPS_DMI_MATCH_INVERT("ThinkPad T42p"),
@@ -536,9 +538,9 @@
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad T43"),
 		HDAPS_DMI_MATCH_LENOVO("ThinkPad T60p"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X40"),
-		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41 Tablet"),
 		HDAPS_DMI_MATCH_NORMAL("ThinkPad X41"),
 		HDAPS_DMI_MATCH_LENOVO("ThinkPad X60"),
+		HDAPS_DMI_MATCH_NORMAL("ThinkPad Z60m"),
 		{ .ident = NULL }
 	};
 

-- 
Jean Delvare

