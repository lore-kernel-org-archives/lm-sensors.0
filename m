From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [PATCH 2.4] I2C updates for 2.4.31-pre1 (1/3)
Message-Id: <20050501191520.7bc41d1b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050501185236.2f76a5ba.khali@linux-fr.org>
In-Reply-To: <20050501185236.2f76a5ba.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>, Corey Minyard <minyard@acm.org>

Fix a typo in a comment in i2c.h. It was originally fixed by Corey
Minyard in Linux 2.6.

http://linux.bkbits.net:8080/linux-2.5/diffs/include/linux/i2c.h@1.48

--- linux-2.4.30-rc1/include/linux/i2c.h.orig	2005-03-19 13:16:55.000000000 +0100
+++ linux-2.4.30-rc1/include/linux/i2c.h	2005-03-19 13:17:40.000000000 +0100
@@ -193,7 +193,7 @@
 	char name[32];				/* textual description 	*/
 	unsigned int id;
 
-	/* If an adapter algorithm can't to I2C-level access, set master_xfer
+	/* If an adapter algorithm can't do I2C-level access, set master_xfer
 	   to NULL. If an adapter algorithm can do SMBus access, set 
 	   smbus_xfer. If set to NULL, the SMBus protocol is simulated
 	   using common I2C messages */


-- 
Jean Delvare
