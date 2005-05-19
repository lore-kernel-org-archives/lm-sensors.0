From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: [PATCH] I2C update for 2.6.5
Message-Id: <10819814502943@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10819814502077@kroah.com>
References: <10819814492866@kroah.com>
In-Reply-To: <10819814492866@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1643.36.10, 2004/03/30 14:27:06-08:00, khali@linux-fr.org

[PATCH] I2C: Incorrect memset in eeprom.c

Quoting Ralf Roesch:

> currently I'm only working with Linux MIPS 2.4 kernel,
> so it would be nice if you could forward the patch for 2.6.

OK, so here we are. Greg, this is the port to 2.6 of Ralf patch that
fixes an incorrect memset while initializing the eeprom driver. Please
apply.


 drivers/i2c/chips/eeprom.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c	Wed Apr 14 15:14:11 2004
+++ b/drivers/i2c/chips/eeprom.c	Wed Apr 14 15:14:11 2004
@@ -197,7 +197,7 @@
 				 sizeof(struct eeprom_data));
 
 	data = (struct eeprom_data *) (new_client + 1);
-	memset(data, 0xff, EEPROM_SIZE);
+	memset(data->data, 0xff, EEPROM_SIZE);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;

