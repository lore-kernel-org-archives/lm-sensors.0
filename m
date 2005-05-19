From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH 2.4] i2c cleanups, third wave (8/8)
Message-Id: <20040111162839.5324314b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

This last patch fixes missing spaces in an error message in i2c-core.c.
Original patch by Ky?sti M?lkki.

Thanks!

--- linux-2.4.25-pre4-k7/drivers/i2c/i2c-core.c	Sun Jan 11 10:33:12 2004
+++ linux-2.4.25-pre4-k8/drivers/i2c/i2c-core.c	Sun Jan 11 13:51:11 2004
@@ -359,8 +359,8 @@
 						       "unregistering driver "
 						       "`%s', the client at "
 						       "address %02x of "
-						       "adapter `%s' could not"
-						       "be detached; driver"
+						       "adapter `%s' could not "
+						       "be detached; driver "
 						       "not unloaded!",
 						       driver->name,
 						       client->addr,



-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
