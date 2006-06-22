From: greg@kroah.com (Greg KH)
Date: Thu, 22 Jun 2006 18:27:40 +0000
Subject: [lm-sensors] [PATCH 14/44] [PATCH] HWMON: hdaps: Update the list of
Message-Id: <1151000936468-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Update the list of systems supported by the hdaps driver:
* Add the "ThinkPad Z60m" entry, reported by Arkadiusz Miskiewicz.
* Add the "ThinkPad H" entry, reported by Frank Gevaerts for some
  ThinkPad R52 models (1846AQG).
* Drop the "ThinkPad X41 Tablet" entry, which looks redundant to me.
And a comment update for good measure.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Cc: Arkadiusz Miskiewicz <arekm at maven.pl>
Cc: Frank Gevaerts <frank at gevaerts.be>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/hdaps.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/hdaps.c b/drivers/hwmon/hdaps.c
index 1659f6c..7841fa0 100644
--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -522,13 +522,15 @@ static int __init hdaps_init(void)
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
@@ -536,9 +538,9 @@ static int __init hdaps_init(void)
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
1.4.0


