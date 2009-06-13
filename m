From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Sat, 13 Jun 2009 17:21:14 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (abituguru3) DMI probing for IX38
Message-Id: <1244913674-9633-4-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Switch the IX38 QuadGT over from port probing to the preferred DMI
probe method.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Tested-by: Dmitriy Fedchenko <dmitriy-fedc@yandex.ru>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/abituguru3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index ad2b343..2908cfc 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -564,7 +564,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x001C, NULL /* Unknown, need DMI string */, {
+	{ 0x001C, "IX38 QuadGT", {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR2",		 1, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		 2, 0, 10, 1, 0 },

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
