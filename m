From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 07 Jun 2013 19:45:26 +0000
Subject: [lm-sensors] [PATCH] smbus_company_id: Add manufacturer IDs for JC 42.4 compliant temperature sensor
Message-Id: <1370634326-10496-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 doc/developers/smbus_company_id |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/developers/smbus_company_id b/doc/developers/smbus_company_id
index b4fd4ec..375a47e 100644
--- a/doc/developers/smbus_company_id
+++ b/doc/developers/smbus_company_id
@@ -26,3 +26,16 @@ This may help identify a chip after doing a 'i2cdump [bus] [address]'.
 0xDA	Dallas
 
 [A-Z]{3} at 0x00-0x02: Fujitsu-Siemens
+
+
+Jedec JC 42.4 compliant temperature sensors provide the manufacturer ID
+in 16-bit register 0x06. Known manufacturer IDs are as follows.
+
+0x001F	Atmel
+0x004D	Maxim
+0x0054	Microchip
+0x00B3	IDT
+0x104A	ST Microelectronics
+0x1131	NXP (Philips)
+0x11D4	Analog Devices
+0x1B09	ON Semiconductor
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
