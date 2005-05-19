From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Hangs with w83781d
Message-Id: <20040221112640.3e4b28ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
In-Reply-To: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Whoops, just noticed: I was looking at 0x4D for the first of those.
> 
> It's 0x49 both before and after the module has been loaded.

OK, makes more sense ;)

I have attached what I think is the correct patch against Linux 2.6.3
(i.e.: without your own change applied). Seems to work for me (but I had
no problem before). Can you confirm that it works as good as your own
change?

If it's OK, I'll backport the change to the two drivers in our CVS
repository that have similar code (w83781d.c and w83627hf.c).

It's actually a great thing that we can finally come to a clean solution
to your problem, 10 months later.

Thanks :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
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
