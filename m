From: Sergey Vlasov <vsu@altlinux.ru>
Date: Tue, 15 Jan 2008 18:57:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (abituguru3) Add AUX4 fan input for
Message-Id: <1200423464-19294-1-git-send-email-vsu@altlinux.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Abit IP35 Pro has 6 fan connectors (CPU, SYS and AUX1-4), but the
entry for AUX4 was missing from the table.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 drivers/hwmon/abituguru3.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index e72a21b..0e6b142 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -528,6 +528,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "AUX1 Fan",		33, 2, 60, 1, 0 },
 		{ "AUX2 Fan",		35, 2, 60, 1, 0 },
 		{ "AUX3 Fan",		36, 2, 60, 1, 0 },
+		{ "AUX4 Fan",		37, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
 	{ 0x001B, "unknown", {
-- 
1.5.3.6.892.g2627


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
