From: gregkh@suse.de (Greg KH)
Date: Thu, 19 May 2005 06:25:48 +0000
Subject: [PATCH] i2c: add adt7461 chip support to lm90 driver's Kconfig entry
Message-Id: <11123113951873@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11123113952683@kroah.com>
References: <11123113914006@kroah.com>
In-Reply-To: <11123113914006@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: khali@linux-fr.org

ChangeSet 1.2347, 2005/03/31 14:31:59-08:00, khali@linux-fr.org

[PATCH] i2c: add adt7461 chip support to lm90 driver's Kconfig entry

Hi Greg, James, all,

> > > Attached is another version of my adt7461 patch, for inclusion in
> > > the 2.6 tree. Reviewed by Jean.
>
> May we have an additional patch to Kconfig for this one?

Here it finally comes.

This simple patch adds a mention to the ADT7461 chip in Kconfig, now
that the lm90 driver supports it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/i2c/chips/Kconfig |    3 +++
 1 files changed, 3 insertions(+)


diff -Nru a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig	2005-03-31 15:16:17 -08:00
+++ b/drivers/i2c/chips/Kconfig	2005-03-31 15:16:17 -08:00
@@ -233,6 +233,9 @@
 	  LM86, LM89 and LM99, Analog Devices ADM1032 and Maxim MAX6657 and
 	  MAX6658 sensor chips.
 
+	  The Analog Devices ADT7461 sensor chip is also supported, but only
+	  if found in ADM1032 compatibility mode.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
 

