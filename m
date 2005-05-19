From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] Incorrect memset in eeprom.c
Message-Id: <20040330203502.350fc28b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Ralf Roesch:

> currently I'm only working with Linux MIPS 2.4 kernel, 
> so it would be nice if you could forward the patch for 2.6.

OK, so here we are. Greg, this is the port to 2.6 of Ralf patch that
fixes an incorrect memset while initializing the eeprom driver. Please
apply.

Thanks.

--- linux-2.6.5-rc2/drivers/i2c/chips/eeprom.c.orig	Mon Mar 29 20:46:02 2004
+++ linux-2.6.5-rc2/drivers/i2c/chips/eeprom.c	Tue Mar 30 20:29:34 2004
@@ -197,7 +197,7 @@
 				 sizeof(struct eeprom_data));
 
 	data = (struct eeprom_data *) (new_client + 1);
-	memset(data, 0xff, EEPROM_SIZE);
+	memset(data->data, 0xff, EEPROM_SIZE);
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
 	new_client->adapter = adapter;


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
