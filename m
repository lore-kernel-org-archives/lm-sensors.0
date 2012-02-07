From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Feb 2012 23:52:24 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) Fix number of fans for NCT6776F
Message-Id: <1328658744-32616-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327672138-5224-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327672138-5224-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6776F can select fan input pins for fans 3 to 5 with a secondary set of
chip register bits. Check that second set of bits in addition to the first set
to detect if fans 3..5 are monitored.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org # 3.0+
Acked-by: Jean Delvare <khali@linux-fr.org>
---
Backport to 3.0
Upstream commit: 585c0fd8216e0c9f98e2434092af7ec0f999522d

 drivers/hwmon/w83627ehf.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 6284515..359bb1e 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -2104,9 +2104,29 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 		fan4min = 0;
 		fan5pin = 0;
 	} else if (sio_data->kind = nct6776) {
-		fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
-		fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
-		fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x02);
+		bool gpok = superio_inb(sio_data->sioreg, 0x27) & 0x80;
+		u8 regval;
+
+		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
+		regval = superio_inb(sio_data->sioreg, SIO_REG_ENABLE);
+
+		if (regval & 0x80)
+			fan3pin = gpok;
+		else
+			fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
+
+		if (regval & 0x40)
+			fan4pin = gpok;
+		else
+			fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C)
+				     & 0x01);
+
+		if (regval & 0x20)
+			fan5pin = gpok;
+		else
+			fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C)
+				     & 0x02);
+
 		fan4min = fan4pin;
 	} else if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b) {
 		fan3pin = 1;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
