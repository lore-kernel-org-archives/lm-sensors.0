From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:41 +0000
Subject: [lm-sensors] [PATCH 10/30] i2c-au1550: Add SMBus functionality flag
Message-Id: <1159318952751-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Domen Puncer <domen.puncer at ultra.si>

i2c-au1550: Add SMBus functionality flag

Add SMBus functionality flag, so we can use eeprom and similar
drivers.

Signed-off-by: Domen Puncer <domen.puncer at ultra.si>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/i2c/busses/i2c-au1550.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1550.c
index 02a359e..7140eb0 100644
--- a/drivers/i2c/busses/i2c-au1550.c
+++ b/drivers/i2c/busses/i2c-au1550.c
@@ -285,7 +285,7 @@ au1550_xfer(struct i2c_adapter *i2c_adap
 static u32
 au1550_func(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static struct i2c_algorithm au1550_algo = {
-- 
1.4.2.1


