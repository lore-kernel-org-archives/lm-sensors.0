From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:46 +0000
Subject: PATCH: i2c: add adt7461 chip support to lm90 driver
Message-Id: <20050327143415.5d153515.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <422C305F.3000301@katalix.com>
In-Reply-To: <422C305F.3000301@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, James, all,

> > > Attached is another version of my adt7461 patch, for inclusion in
> > > the 2.6 tree. Reviewed by Jean.
> 
> May we have an additional patch to Kconfig for this one?

Here it finally comes.

This simple patch adds a mention to the ADT7461 chip in Kconfig, now
that the lm90 driver supports it.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.12-rc1-mm3/drivers/i2c/chips/Kconfig.orig	2005-03-26 07:00:03.000000000 +0100
+++ linux-2.6.12-rc1-mm3/drivers/i2c/chips/Kconfig	2005-03-27 14:33:02.000000000 +0200
@@ -233,6 +233,9 @@
 	  LM86, LM89 and LM99, Analog Devices ADM1032 and Maxim MAX6657 and
 	  MAX6658 sensor chips.
 
+	  The Analog Devices ADT7461 sensor chip is also supported, but only
+	  if found in ADM1032 compatibility mode.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm90.
 

-- 
Jean Delvare
