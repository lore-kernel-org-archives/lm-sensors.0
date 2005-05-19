From: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <20040105163441.GC2415@stop.crashing.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 04, 2004 at 05:08:49PM +1100, Rusty Russell wrote:

> In message <1072821970727@kroah.com> you write:
> > +/* If fix_hstcfg is set to anything different from 0, we reset one of the
> > +   registers to be a valid value. */
> > +static int fix_hstcfg = 0;
> > +MODULE_PARM(fix_hstcfg, "i");
> > +MODULE_PARM_DESC(fix_hstcfg,
> > +		"Fix config register. Needed on some boards (Force CPCI735).");
> > +
> 
> BTW, it'd be nice if someone converted these to module_param, too...

Done.
=== drivers/i2c/busses/i2c-piix4.c 1.21 vs edited ==--- 1.21/drivers/i2c/busses/i2c-piix4.c	Tue Dec 30 13:03:31 2003
+++ edited/drivers/i2c/busses/i2c-piix4.c	Mon Jan  5 09:33:17 2004
@@ -31,6 +31,7 @@
 /* #define DEBUG 1 */
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -88,13 +89,13 @@
 /* If force is set to anything different from 0, we forcibly enable the
    PIIX4. DANGEROUS! */
 static int force = 0;
-MODULE_PARM(force, "i");
+module_param (force, int, 0);
 MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
 
 /* If force_addr is set to anything different from 0, we forcibly enable
    the PIIX4 at the given address. VERY DANGEROUS! */
 static int force_addr = 0;
-MODULE_PARM(force_addr, "i");
+module_param (force_addr, int, 0);
 MODULE_PARM_DESC(force_addr,
 		 "Forcibly enable the PIIX4 at the given address. "
 		 "EXTREMELY DANGEROUS!");
@@ -102,7 +103,7 @@
 /* If fix_hstcfg is set to anything different from 0, we reset one of the
    registers to be a valid value. */
 static int fix_hstcfg = 0;
-MODULE_PARM(fix_hstcfg, "i");
+module_param (fix_hstcfg, int, 0);
 MODULE_PARM_DESC(fix_hstcfg,
 		"Fix config register. Needed on some boards (Force CPCI735).");
 
-- 
Tom Rini
http://gate.crashing.org/~trini/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040105/d0ca16ae/attachment.bin
