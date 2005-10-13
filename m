From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 13 Oct 2005 12:16:10 +0000
Subject: [lm-sensors] [PATCH] drivers/i2c/chips/eeprom.c - missing static
Message-Id: <20051013101444.GA26868@home.fluff.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

eeprom_detect is first declared static and then when
the function is actually implemented, there is no
static.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
-------------- next part --------------
--- linux-2.6.14-rc4-bjd1/drivers/i2c/chips/eeprom.c	2005-10-11 10:56:32.000000000 +0100
+++ linux-2.6.14-rc4-bjd2/drivers/i2c/chips/eeprom.c	2005-10-13 11:11:40.000000000 +0100
@@ -155,7 +155,7 @@ static int eeprom_attach_adapter(struct 
 }
 
 /* This function is called by i2c_probe */
-int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
+static int eeprom_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	struct i2c_client *new_client;
 	struct eeprom_data *data;
