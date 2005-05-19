From: ladis@linux-mips.org (Ladislav Michl)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH] ds1337: export ds1337_do_command
Message-Id: <20050510121814.GB2492@orphique>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050504061438.GD1439@orphique> <1DTwF8-18P-00@press.kroah.org> <20050508204021.627f9cd1.khali@linux-fr.org> <427E6E21.60001@katalix.com> <20050508222351.08bfe2e1.khali@linux-fr.org>
In-Reply-To: <20050508222351.08bfe2e1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>
Cc: James Chapman <jchapman@katalix.com>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@Stimpy.netroedge.com>

On Sun, May 08, 2005 at 10:23:51PM +0200, Jean Delvare wrote:
> Hi James,
> 
> > I suggest that Ladislav's patch should still be applied and a
> > separate patch be submitted to export the interface to modules.
> 
> Either way is fine with me as long as it actually happens.

Export ds1337_do_command so it could be used also if driver is built as
module.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>

--- linux-omap/drivers/i2c/chips/ds1337.c.orig	2005-05-10 14:10:49.637992600 +0200
+++ linux-omap/drivers/i2c/chips/ds1337.c	2005-05-10 14:13:05.064404656 +0200
@@ -380,5 +380,7 @@
 MODULE_DESCRIPTION("DS1337 RTC driver");
 MODULE_LICENSE("GPL");
 
+EXPORT_SYMBOL(ds1337_do_command);
+
 module_init(ds1337_init);
 module_exit(ds1337_exit);
