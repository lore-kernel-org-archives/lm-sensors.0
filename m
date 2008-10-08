From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Wed, 08 Oct 2008 17:06:00 +0000
Subject: [lm-sensors] [PATCH 2/2] abituguru3: enable DMI probing feature on
Message-Id: <1223485560-3806-3-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Enable driver checking of the DMI product name (when enabled) on
an Abit AT8 32X, instead of falling back to a manual probe. This
eliminates false negatives and eventually will help avoid
unnecessary bus probes on unsupported mainboards.

Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
Tested-by: Daniel Exner <dex@dragonslave.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: lm-sensors@lm-sensors.org

---

 drivers/hwmon/abituguru3.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index d568c65..8d43f3b 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -279,7 +279,7 @@ static const struct abituguru3_motherboard_info abituguru3_motherboards[] = {
 		{ "OTES1 Fan",		36, 2, 60, 1, 0 },
 		{ NULL, 0, 0, 0, 0, 0 } }
 	},
-	{ 0x0011, NULL /* Abit AT8 32X, need DMI string */, {
+	{ 0x0011, "AT8 32X(ATI RD580-ULI M1575)", {
 		{ "CPU Core",		 0, 0, 10, 1, 0 },
 		{ "DDR",		 1, 0, 20, 1, 0 },
 		{ "DDR VTT",		 2, 0, 10, 1, 0 },

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
