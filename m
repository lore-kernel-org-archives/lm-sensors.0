From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 28 Jan 2012 23:15:13 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (w83627ehf) Fix number of fans for NCT6776F
Message-Id: <1327792513-10308-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

NCT6776F can select fan input pins for fans 3 to 5 with a secondary set of
chip register bits. Check that second set of bits in addition to the first set
to detect if fans 3..5 are monitored.

Reported-by: C. Comren <ccomren@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: GPIO pins 90..92 have higher priority than pin 3..5, so check for those first.
    Added some blank lines to improve readability

CC, can you test this version ? It is in the "testing" branch of the github
repository.

 drivers/hwmon/w83627ehf.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 8d9620f..598d5e9 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1931,9 +1931,26 @@ w83627ehf_check_fan_inputs(const struct w83627ehf_sio_data *sio_data,
 		fan4min = 0;
 		fan5pin = 0;
 	} else if (sio_data->kind = nct6776) {
-		fan3pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x40);
-		fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
-		fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x02);
+		bool gpok = superio_inb(sio_data->sioreg, 0x27) & 0x80;
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
+			fan4pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x01);
+
+		if (regval & 0x20)
+			fan5pin = gpok;
+		else
+			fan5pin = !!(superio_inb(sio_data->sioreg, 0x1C) & 0x02);
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
