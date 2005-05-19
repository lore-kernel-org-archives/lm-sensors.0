From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH 2.6] Fix debug bug in lm83 driver
Message-Id: <20040111175123.54cdeb9f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The following patch fixes lm83 failing to compile if DEBUG is set.

BTW, how does one enable DEBUG? I tried to add "-DDEBUG" in the main
Makefile with no success, then I tried to add "#define DEBUG" in the
driver itself but it didn't work either. I had to run the correct
compilation command directly by myself with -DDEBUG to get it to work. I
just can't understand why the two other ways (especially the second)
fails to work. Does Voodoo magic surround us? Help! ;)

--- linux-2.6.1/drivers/i2c/chips/lm83.c.orig	Sun Jan 11 17:40:55 2004
+++ linux-2.6.1/drivers/i2c/chips/lm83.c	Sun Jan 11 17:16:59 2004
@@ -270,7 +270,7 @@
 		    & 0x48) != 0x00) ||
 		    ((i2c_smbus_read_byte_data(new_client, LM83_REG_R_CONFIG)
 		    & 0x41) != 0x00)) {
-			dev_dbg(&client->dev,
+			dev_dbg(&adapter->dev,
 			    "LM83 detection failed at 0x%02x.\n", address);
 			goto exit_free;
 		}


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
