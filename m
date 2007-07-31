From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:39:59 +0000
Subject: [lm-sensors] [PATCH] hwmon: make abituguru3_read_increment_offset()
Message-Id: <11858460012909-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>

abituguru3_read_increment_offset() can become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/abituguru3.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index a003d10..cdd8b6d 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -691,8 +691,9 @@ static int abituguru3_read(struct abituguru3_data *data, u8 bank, u8 offset,
 
 /* Sensor settings are stored 1 byte per offset with the bytes
    placed add consecutive offsets. */
-int abituguru3_read_increment_offset(struct abituguru3_data *data, u8 bank,
-	u8 offset, u8 count, u8 *buf, int offset_count)
+static int abituguru3_read_increment_offset(struct abituguru3_data *data,
+					    u8 bank, u8 offset, u8 count,
+					    u8 *buf, int offset_count)
 {
 	int i, x;
 
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
