From: gregkh@suse.de (Greg KH)
Date: Tue, 12 Jul 2005 00:04:34 +0000
Subject: [lm-sensors] [PATCH] I2C: drop bogus eeprom comment
Message-Id: <11211193762160@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11211193763938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: khali@linux-fr.org

[PATCH] I2C: drop bogus eeprom comment

This simple patch drops an out-of-date comment in the eeprom i2c chip
driver.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 2db32767874fe53faff4f80de878ca19927efc1f
tree 4ac3024bd4e29e7770f96244b386429d991c58f7
parent a0920e10438e9fe8b22aba607083347c84458ed8
author Jean Delvare <khali@linux-fr.org> Thu, 23 Jun 2005 23:43:00 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:36 -0700

 drivers/i2c/chips/eeprom.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -173,9 +173,6 @@ int eeprom_detect(struct i2c_adapter *ad
 					    | I2C_FUNC_SMBUS_BYTE))
 		goto exit;
 
-	/* OK. For now, we presume we have a valid client. We now create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access eeprom_{read,write}_value. */
 	if (!(data = kmalloc(sizeof(struct eeprom_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;

