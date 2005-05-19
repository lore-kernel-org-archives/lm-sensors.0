From: bunk@stusta.de (Adrian Bunk)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [2.6 patch] 2.6.10-mm2: let I2C_ALGO_SGI depend on MIPS
Message-Id: <20050106181519.GG3096@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050106002240.00ac4611.akpm@osdl.org>
In-Reply-To: <20050106002240.00ac4611.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com, Ladislav Michl <ladis@linux-mips.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com, ralf@linux-mips.org, linux-mips@linux-mips.org

On Thu, Jan 06, 2005 at 12:22:40AM -0800, Andrew Morton wrote:
>...
> All 560 patches:
>...
> bk-i2c.patch
>...


There's no reason for offering a MIPS-only driver on other architectures 
(even though it does compile).

Even better dependencies on specific MIPS variables might be possible 
that obsolete this patch, but this patch fixes at least the !MIPS case.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-mm2-full/drivers/i2c/algos/Kconfig.old	2005-01-06 19:07:16.000000000 +0100
+++ linux-2.6.10-mm2-full/drivers/i2c/algos/Kconfig	2005-01-06 19:08:22.000000000 +0100
@@ -61,7 +61,7 @@
 
 config I2C_ALGO_SGI
 	tristate "I2C SGI interfaces"
-	depends on I2C
+	depends on I2C && MIPS
 	help
 	  Supports the SGI interfaces like the ones found on SGI Indy VINO
 	  or SGI O2 MACE.

