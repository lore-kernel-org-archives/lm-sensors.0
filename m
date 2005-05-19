From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <1074556763176@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567623125@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.12, 2004/01/14 11:44:33-08:00, khali@linux-fr.org

[PATCH] I2C: Fix debug bug in lm83 driver

The following patch fixes lm83 failing to compile if DEBUG is set.


 drivers/i2c/chips/lm83.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/lm83.c b/drivers/i2c/chips/lm83.c
--- a/drivers/i2c/chips/lm83.c	Mon Jan 19 15:31:08 2004
+++ b/drivers/i2c/chips/lm83.c	Mon Jan 19 15:31:08 2004
@@ -270,7 +270,7 @@
 		    & 0x48) != 0x00) ||
 		    ((i2c_smbus_read_byte_data(new_client, LM83_REG_R_CONFIG)
 		    & 0x41) != 0x00)) {
-			dev_dbg(&client->dev,
+			dev_dbg(&adapter->dev,
 			    "LM83 detection failed at 0x%02x.\n", address);
 			goto exit_free;
 		}

