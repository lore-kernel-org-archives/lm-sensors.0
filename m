From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: [PATCH 2.6] Fix i2c-core.c with DEBUG
Message-Id: <20040118123749.5001d609.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

At the moment, i2c-core.c fails compiling with DEBUG. Following patch
should fix that.

--- linux-2.6.1-k1/drivers/i2c/i2c-core.c	Fri Jan 16 20:10:16 2004
+++ linux-2.6.1-k3/drivers/i2c/i2c-core.c	Sun Jan 18 12:16:46 2004
@@ -373,7 +373,7 @@
 	}
 
 	DEB(dev_dbg(&adapter->dev, "client [%s] registered to adapter\n",
-			client->dev.name));
+			client->name));
 
 	if (client->flags & I2C_CLIENT_ALLOW_USE)
 		client->usage_count = 0;


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
