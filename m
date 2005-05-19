From: ladis@linux-mips.org (Ladislav Michl)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH] ds1337: export ds1337_do_command
Message-Id: <20050511083254.GA12146@orphique>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050504061438.GD1439@orphique> <1DTwF8-18P-00@press.kroah.org> <20050508204021.627f9cd1.khali@linux-fr.org> <427E6E21.60001@katalix.com> <20050508222351.08bfe2e1.khali@linux-fr.org> <20050510121814.GB2492@orphique> <20050510175549.GC1530@suse.de>
In-Reply-To: <20050510175549.GC1530@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>, James Chapman <jchapman@katalix.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

On Tue, May 10, 2005 at 10:55:49AM -0700, Greg KH wrote:
> > --- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-05-10 14:10:49.637992600 +0200
> > +++ linux-omap/drivers/i2c/chips/ds1337.c	2005-05-10 14:13:05.064404656 +0200
> > @@ -380,5 +380,7 @@
> >  MODULE_DESCRIPTION("DS1337 RTC driver");
> >  MODULE_LICENSE("GPL");
> >  
> > +EXPORT_SYMBOL(ds1337_do_command);
> 
> EXPORT_SYMBOL_GPL() ok?

Export ds1337_do_command so it could be used also if driver is built as
module.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-05-10 14:10:49.000000000 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-05-11 10:28:13.152690512 +0200
@@ -380,5 +380,7 @@
 MODULE_DESCRIPTION("DS1337 RTC driver");
 MODULE_LICENSE("GPL");
 
+EXPORT_SYMBOL_GPL(ds1337_do_command);
+
 module_init(ds1337_init);
 module_exit(ds1337_exit);
