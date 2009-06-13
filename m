From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Sat, 13 Jun 2009 17:21:12 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (abituguru3) DMI probing for
Message-Id: <1244913674-9633-2-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Switch the AB9 over from port probing to the preferred DMI
probe method.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Tested-by: Nygel Lyndley <nygel.lyndley@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/abituguru3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index ad2b343..49828b0 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -357,7 +357,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX5 Fan",		39, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0014, NULL /* Abit AB9 Pro, need DMI string */, {
+	{ 0x0014, "AB9", /* + AB9 Pro */ {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 10, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
