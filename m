From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Tue, 21 Oct 2008 16:59:31 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (abituguru3) Cosmetic whitespace
Message-Id: <1224608373-27352-2-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

As the probable result of zealous copy/pasting, many supported boards
contain sensor names with trailing whitespace. Though this is not a
huge problem, it is inconsistent with other sensor names, and with
other similar hwmon drivers.

Additionally, the DMI nag message added in 2.6.27 was missing a
space between two sentence fragments -- might as well clean that up
too.

Doesn't alter any kernel text, just data.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Reported-by: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/abituguru3.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index d9e7a49..c28cd6c 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -178,7 +178,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "+3.3V",		10, 0, 20, 1, 0 },
 		{ "5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
 		{ "PWM",		26, 1, 1, 1, 0 },
 		{ "CPU Fan",		32, 2, 60, 1, 0 },
 		{ "NB Fan",		33, 2, 60, 1, 0 },
@@ -200,7 +200,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "+3.3V",		10, 0, 20, 1, 0 },
 		{ "5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
 		{ "PWM1",		26, 1, 1, 1, 0 },
 		{ "PWM2",		27, 1, 1, 1, 0 },
 		{ "PWM3",		28, 1, 1, 1, 0 },
@@ -229,7 +229,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "+3.3V",		10, 0, 20, 1, 0 },
 		{ "5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
 		{ "PWM",		26, 1, 1, 1, 0 },
 		{ "CPU Fan",		32, 2, 60, 1, 0 },
 		{ "NB Fan",		33, 2, 60, 1, 0 },
@@ -250,7 +250,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "+3.3V",		10, 0, 20, 1, 0 },
 		{ "5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
 		{ "PWM",		26, 1, 1, 1, 0 },
 		{ "CPU Fan",		32, 2, 60, 1, 0 },
 		{ "NB Fan",		33, 2, 60, 1, 0 },
@@ -342,7 +342,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "+3.3V",		10, 0, 20, 1, 0 },
 		{ "5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
 		{ "PWM1",		26, 1, 1, 1, 0 },
 		{ "PWM2",		27, 1, 1, 1, 0 },
 		{ "PWM3",		28, 1, 1, 1, 0 },
@@ -371,7 +371,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "+3.3V",		10, 0, 20, 1, 0 },
 		{ "5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
 		{ "PWM",		26, 1, 1, 1, 0 },
 		{ "CPU Fan",		32, 2, 60, 1, 0 },
 		{ "NB Fan",		33, 2, 60, 1, 0 },
@@ -416,7 +416,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "+3.3V",		10, 0, 20, 1, 0 },
 		{ "5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
 		{ "PWM1",		26, 1, 1, 1, 0 },
 		{ "PWM2",		27, 1, 1, 1, 0 },
 		{ "PWM3",		28, 1, 1, 1, 0 },
@@ -446,7 +446,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "ATX +3.3V",		10, 0, 20, 1, 0 },
 		{ "ATX 5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		26, 1, 1, 1, 0 },
+		{ "System",		26, 1, 1, 1, 0 },
 		{ "PWM",		27, 1, 1, 1, 0 },
 		{ "CPU FAN",		32, 2, 60, 1, 0 },
 		{ "SYS FAN",		34, 2, 60, 1, 0 },
@@ -469,7 +469,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "+3.3V",		10, 0, 20, 1, 0 },
 		{ "5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
 		{ "PWM Phase1",		26, 1, 1, 1, 0 },
 		{ "PWM Phase2",		27, 1, 1, 1, 0 },
 		{ "PWM Phase3",		28, 1, 1, 1, 0 },
@@ -487,7 +487,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "DDR2",		13, 0, 20, 1, 0 },
 		{ "DDR2 VTT",		14, 0, 10, 1, 0 },
 		{ "CPU VTT",		 3, 0, 20, 1, 0 },
-		{ "NB 1.2V ",		 4, 0, 10, 1, 0 },
+		{ "NB 1.2V",		 4, 0, 10, 1, 0 },
 		{ "SB 1.5V",		 6, 0, 10, 1, 0 },
 		{ "HyperTransport",	 5, 0, 10, 1, 0 },
 		{ "ATX +12V (24-Pin)",	12, 0, 60, 1, 0 },
@@ -496,7 +496,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "ATX +3.3V",		10, 0, 20, 1, 0 },
 		{ "ATX 5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
 		{ "PWM Phase1",		26, 1, 1, 1, 0 },
 		{ "PWM Phase2",		27, 1, 1, 1, 0 },
 		{ "PWM Phase3",		28, 1, 1, 1, 0 },
@@ -523,8 +523,8 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "+3.3V",		10, 0, 20, 1, 0 },
 		{ "5VSB",		11, 0, 30, 1, 0 },
 		{ "CPU",		24, 1, 1, 1, 0 },
-		{ "System ",		25, 1, 1, 1, 0 },
-		{ "PWM ",		26, 1, 1, 1, 0 },
+		{ "System",		25, 1, 1, 1, 0 },
+		{ "PWM",		26, 1, 1, 1, 0 },
 		{ "PWM Phase2",		27, 1, 1, 1, 0 },
 		{ "PWM Phase3",		28, 1, 1, 1, 0 },
 		{ "PWM Phase4",		29, 1, 1, 1, 0 },
@@ -947,7 +947,7 @@ static int __devinit abituguru3_probe(struct platform_device *pdev)
 	if (!abituguru3_motherboards[i].dmi_name) {
 		printk(KERN_WARNING ABIT_UGURU3_NAME ": this motherboard was "
 			"not detected using DMI. Please send the output of "
-			"\"dmidecode\" to the abituguru3 maintainer"
+			"\"dmidecode\" to the abituguru3 maintainer "
 			"(see MAINTAINERS)\n");
 	}
 #endif

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
