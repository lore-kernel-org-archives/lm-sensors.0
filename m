From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Fix lm90.c with DEBUG
Message-Id: <20040118123521.28bb2f2a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The recent patch that fixes lm83.c with DEBUG also applies to lm90.c. No
wonder since I used the first as a template when porting the second.
Patch follows.

--- linux-2.6.1-k1/drivers/i2c/chips/lm90.c	Sun Jan 18 09:57:28 2004
+++ linux-2.6.1-k3/drivers/i2c/chips/lm90.c	Sun Jan 18 12:19:15 2004
@@ -320,8 +320,8 @@
 
 		if ((reg_config1 & 0x2A) != 0x00
 		 || reg_convrate > 0x0A) {
-			dev_dbg(&client->dev,
-				"LM90 detection failed at 0x%02x.\n"
+			dev_dbg(&adapter->dev,
+				"LM90 detection failed at 0x%02x.\n",
 				address);
 			goto exit_free;
 		}


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
