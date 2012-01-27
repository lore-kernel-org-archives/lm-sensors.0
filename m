From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Jan 2012 13:48:58 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) Fix number of fans for NCT6776F
Message-Id: <1327672138-5224-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6776F can select fan input pins for fans 3 to 5 with a secondary set of
chip register bits. Check that second set of bits in addition to the first set
to detect if fans 3..5 are monitored.

Reported-by: C. Comren <ccomren@@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83627ehf.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 0e0af04..c0ef1a3 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1914,9 +1914,20 @@ w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
 		fan4min = 0;
 		fan5pin = 0;
 	} else if (sio_data->kind = nct6776) {
+		u8 val;
+
 		fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
 		fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
 		fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x02);
+		/* Test secondary set of fan input select registers */
+		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
+		val = superio_inb(sio_data->sioreg, SIO_REG_ENABLE);
+		if (!fan3pin && (val & 0x80))
+			fan3pin = true;
+		if (!fan4pin && (val & 0x40))
+			fan4pin = true;
+		if (!fan5pin && (val & 0x20))
+			fan5pin = true;
 		fan4min = fan4pin;
 	} else if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b) {
 		fan3pin = 1;
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
