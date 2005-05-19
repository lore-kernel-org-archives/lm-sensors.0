From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <20040325200219.69dedda3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Quoting myself:

> 3* Drop adm1021's limit init. This was already done in the 2.4 driver
> and should have been done in 2.6 as well.

Here is a patch that does that. It also prevents bit 7 (and unused bits)
of configuration register from being reset, as was discussed before:
  http://archives.andrew.net.au/lm-sensors/msg04593.html
That second part needs to be backported to the 2.4 driver, and I will do
so.

Additionally, we get rid of a useless label.

The patch is untested (I don't own any supported chip) but quite
straightforward IMHO.

Please apply,
thanks.

--- linux-2.6.5-rc1/drivers/i2c/chips/adm1021.c.orig	Sun Mar 21 18:32:50 2004
+++ linux-2.6.5-rc1/drivers/i2c/chips/adm1021.c	Thu Mar 25 19:45:18 2004
@@ -98,10 +98,6 @@
 they don't quite work like a thermostat the way the LM75 does.  I.e., 
 a lower temp than THYST actually triggers an alarm instead of 
 clearing it.  Weird, ey?   --Phil  */
-#define adm1021_INIT_TOS		60
-#define adm1021_INIT_THYST		20
-#define adm1021_INIT_REMOTE_TOS		60
-#define adm1021_INIT_REMOTE_THYST	20
 
 /* Each client has this additional data */
 struct adm1021_data {
@@ -306,7 +302,7 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto error3;
+		goto error1;
 
 	/* Initialize the ADM1021 chip */
 	adm1021_init_client(new_client);
@@ -324,7 +320,6 @@
 
 	return 0;
 
-error3:
 error1:
 	kfree(new_client);
 error0:
@@ -333,17 +328,9 @@
 
 static void adm1021_init_client(struct i2c_client *client)
 {
-	/* Initialize the adm1021 chip */
-	adm1021_write_value(client, ADM1021_REG_TOS_W,
-			    adm1021_INIT_TOS);
-	adm1021_write_value(client, ADM1021_REG_THYST_W,
-			    adm1021_INIT_THYST);
-	adm1021_write_value(client, ADM1021_REG_REMOTE_TOS_W,
-			    adm1021_INIT_REMOTE_TOS);
-	adm1021_write_value(client, ADM1021_REG_REMOTE_THYST_W,
-			    adm1021_INIT_REMOTE_THYST);
 	/* Enable ADC and disable suspend mode */
-	adm1021_write_value(client, ADM1021_REG_CONFIG_W, 0);
+	adm1021_write_value(client, ADM1021_REG_CONFIG_W,
+		adm1021_read_value(client, ADM1021_REG_CONFIG_R) & 0xBF);
 	/* Set Conversion rate to 1/sec (this can be tinkered with) */
 	adm1021_write_value(client, ADM1021_REG_CONV_RATE_W, 0x04);
 }


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
