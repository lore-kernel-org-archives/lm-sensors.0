From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Tue, 13 Jan 2009 16:56:38 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (abituguru3) enable DMI probing
Message-Id: <1231865798-12187-3-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Switch the IN9 32X MAX over from port probing to the preferred DMI
probe method.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Tested-by: Paul Hartman <paul.hartman+gentoo@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/abituguru3.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 70bb854..3550da7 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -482,7 +482,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0019, NULL /* Unknown, need DMI string */, {
+	{ 0x0019, "IN9 32X MAX", {
 		{ "CPU Core",		 7, 0, 10, 1, 0 },
 		{ "DDR2",		13, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		14, 0, 10, 1, 0 },

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
