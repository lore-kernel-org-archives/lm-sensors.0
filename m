From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 17 Jul 2013 20:53:08 +0000
Subject: [lm-sensors] [PATCH v3 4/4] eeprom: Add a MODULE_DEVICE_TABLE
Message-Id: <5661ebb4676a4d20678f369df3a2da5d587e9100.1374093761.git.luto@amacapital.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374093761.git.luto@amacapital.net>
In-Reply-To: <cover.1374093761.git.luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>

The new DIMM-bus code can detect eeproms, so give the eeprom driver
an appropriate modalias.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/misc/eeprom/eeprom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/eeprom.c b/drivers/misc/eeprom/eeprom.c
index c169e07..1ec85b8 100644
--- a/drivers/misc/eeprom/eeprom.c
+++ b/drivers/misc/eeprom/eeprom.c
@@ -215,6 +215,7 @@ static const struct i2c_device_id eeprom_id[] = {
 	{ "eeprom", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, eeprom_id);
 
 static struct i2c_driver eeprom_driver = {
 	.driver = {
-- 
1.8.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
