From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [PATCH 2.6] Hangs with w83781d
Message-Id: <20040221151755.7b288c5b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here is a patch for the w83781d driver that prevents register bits from
being arbitrary changed when we force temp2/3 to comparator mode. Keith
Duthie had been reporting various problems with that driver and finally
found that this arbitrary change was the cause of them. He also tested
this patch, which he confirmed to work.

I have backported this change to the w83781d driver in our CVS
repository, as well as in our w83627hf, which had the same problem.

Please apply.
Thanks.


--- linux-2.6.3/drivers/i2c/chips/w83781d.c.orig	Thu Feb  5 22:24:55 2004
+++ linux-2.6.3/drivers/i2c/chips/w83781d.c	Sat Feb 21 11:07:48 2004
@@ -1632,7 +1632,11 @@
 		if (type != w83781d) {
 			/* enable comparator mode for temp2 and temp3 so
 			   alarm indication will work correctly */
-			w83781d_write_value(client, W83781D_REG_IRQ, 0x41);
+			i = w83781d_read_value(client, W83781D_REG_IRQ);
+			if (!(i & 0x40))
+				w83781d_write_value(client, W83781D_REG_IRQ,
+						    i | 0x40);
+
 			for (i = 0; i < 3; i++)
 				data->pwmenable[i] = 1;
 		}

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
