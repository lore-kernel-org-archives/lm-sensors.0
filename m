From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 21:03:42 +0000
Subject: [lm-sensors] [PATCH 01/16] i2c: Static function fixes, 1 of 4
Message-Id: <20051026210412.5080cf67.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Ben Dooks <ben-linux@fluff.org>
Content-Disposition: inline; filename=static-01-i2c-eeprom.patch

eeprom_detect is first declared static and then when
the function is actually implemented, there is no static.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/i2c/chips/eeprom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.14-rc4.orig/drivers/i2c/chips/eeprom.c	2005-10-13 22:59:00.000000000 +0200
+++ linux-2.6.14-rc4/drivers/i2c/chips/eeprom.c	2005-10-14 19:06:12.000000000 +0200
@@ -155,7 +155,7 @@
 }
 
 /* This function is called by i2c_probe */
-int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
+static int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct eeprom_data *data;

-- 
Jean Delvare
