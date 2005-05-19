From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <20040111215054.61d28339.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > They should be converted.  From module.h:
> > 	/* DEPRECATED: Do not use. */
> > 	#define MODULE_PARM(var,type) 	\
> > 	...
> 
> Note that realistically, it's not going away in 2.6, so mass migration
> doesn't really win anything.  However, I never implemented mixing old
> and new style in the same module, so if you're adding a parameter, it
> makes sense to convert them all.

OK, I don't have much time for a mass conversion anyway. Greg, could you
please apply the following patch to the "porting-clients" document so
that at least the new drivers don't need to be converted afterwards?

Thanks.

--- linux-2.6.1-k1/Documentation/i2c/porting-clients.orig	Fri Jan  9 19:12:58 2004
+++ linux-2.6.1-k1/Documentation/i2c/porting-clients	Sun Jan 11 21:45:06 2004
@@ -92,7 +92,10 @@
   i2c_get_clientdata(client) instead.
 
 * [Interface] Init function should not print anything. Make sure
-  there is a MODULE_LICENSE() line.
+  there is a MODULE_LICENSE() line. MODULE_PARM() is replaced
+  by module_param(). Note that module_param has a third parameter,
+  that you should set to 0 by default. See include/linux/moduleparam.h
+  for details.
 
 Coding policy:
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
