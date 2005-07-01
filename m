From: bunk@stusta.de (Adrian Bunk)
Date: Fri, 01 Jul 2005 00:18:39 +0000
Subject: [lm-sensors] [2.6 patch] SENSORS_ATXP1 must select I2C_SENSOR
Message-Id: <20050630221727.GE27478@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050630234709.1ad1512a@DreaM.darnet>
In-Reply-To: <20050630234709.1ad1512a@DreaM.darnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastian Pigulak <dreamin@interia.pl>
Cc: linux-kernel@vger.kernel.org, Sebastian Witt <se.witt@gmx.net>, greg@kroah.com, khali@linux-fr.org, lm-sensors@lm-sensors.org

On Thu, Jun 30, 2005 at 11:47:09PM +0200, Sebastian Pigulak wrote:

> Hey,

Hi Sebastian,

> I've tried patching linux-2.6.13-RC1 with patch-2.6.13-rc1-git2 and building atxp1(it allows Vcore voltage changing) into the kernel. Unfortunately, the kernel compilation stops with:
> 
> LD      init/built-in.o
> LD      vmlinux
> drivers/built-in.o(.text+0x92298): In function `atxp1_detect':
> : undefined reference to `i2c_which_vrm'
> drivers/built-in.o(.text+0x921ae): In function `atxp1_attach_adapter':
> : undefined reference to `i2c_detect'
> make: *** [vmlinux] B??d 1
> => ERROR: Build Failed.  Aborting... 
> 
> Could someone have a look at the module and possibly fix it up?

The patch below should fix it.

cu
Adrian


<--  snip  -->


SENSORS_ATXP1 must select I2C_SENSOR.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm2-full/drivers/i2c/chips/Kconfig.old	2005-06-30 23:56:34.000000000 +0200
+++ linux-2.6.12-mm2-full/drivers/i2c/chips/Kconfig	2005-06-30 23:57:08.000000000 +0200
@@ -80,6 +80,7 @@
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Attansic ATXP1 VID
 	  controller.
