From: Nicolas Boichat <nicolas@boichat.ch>
Date: Tue, 29 Jul 2008 15:02:15 +0000
Subject: [lm-sensors] [PATCH 1/2] Support for Intel iMac in applesmc
Message-Id: <488F30F7.4030804@boichat.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <1216814135.5834.9.camel@sirius>
In-Reply-To: <1216814135.5834.9.camel@sirius>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: roberto@unbit.it, mactel-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, LM Sensors <lm-sensors@lm-sensors.org>, Andrew Morton <akpm@linux-foundation.org>

Hi all,

Roberto De Ioris wrote:
> Hi all, this patch (2.6.26 vanilla) add supports for fans and
> temperature sensors on intel iMac.
>
> Tested on iMac 24" 2.8ghz (iMac8,1), it supports the following sensors:
>   
Here is a slightly modified version (Andrew realigned the sensors list).

Mark: If the MAINTAINERS file is correct, it should go in your git tree, 
right?

Thanks.

This patch (2.6.26 vanilla) adds support for fans and temperature sensors
on Intel iMac.

Tested on iMac 24" 2.8ghz (iMac8,1), it supports the following sensors:

cpu A
ambient
gpu
gpu diode
gpu heatsink
hd bay 1
memory controller
optical drive
power

Signed-off-by: Roberto De Ioris <roberto@unbit.it>
Signed-off-by: Nicolas Boichat <nicolas@boichat.ch>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/hwmon/applesmc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index aacc0c4..52d842b 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -98,6 +98,9 @@ static const char* temperature_sensors_sets[][36] = {
 	  "TH1P", "TH2P", "TH3P", "TMAP", "TMAS", "TMBS", "TM0P", "TM0S",
 	  "TM1P", "TM1S", "TM2P", "TM2S", "TM3S", "TM8P", "TM8S", "TM9P",
 	  "TM9S", "TN0H", "TS0C", NULL },
+/* Set 5: iMac */
+	{ "TC0D", "TA0P", "TG0P", "TG0D", "TG0H", "TH0P", "Tm0P", "TO0P",
+	  "Tp0C", NULL },
 };
 
 /* List of keys used to read/write fan speeds */
@@ -1223,6 +1226,8 @@ static __initdata struct dmi_match_data applesmc_dmi_data[] = {
 	{ .accelerometer = 0, .light = 0, .temperature_set = 3 },
 /* MacPro: temperature set 4 */
 	{ .accelerometer = 0, .light = 0, .temperature_set = 4 },
+/* iMac: temperature set 5 */
+	{ .accelerometer = 0, .light = 0, .temperature_set = 5 },
 };
 
 /* Note that DMI_MATCH(...,"MacBook") will match "MacBookPro1,1".
@@ -1248,6 +1253,10 @@ static __initdata struct dmi_system_id applesmc_whitelist[] = {
 	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
 	  DMI_MATCH(DMI_PRODUCT_NAME,"MacPro2") },
 		(void*)&applesmc_dmi_data[4]},
+	{ applesmc_dmi_match, "Apple iMac", {
+	  DMI_MATCH(DMI_BOARD_VENDOR,"Apple"),
+	  DMI_MATCH(DMI_PRODUCT_NAME,"iMac") },
+		(void*)&applesmc_dmi_data[5]},
 	{ .ident = NULL }
 };
 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
