From: gregkh@suse.de (Greg KH)
Date: Tue, 12 Jul 2005 00:04:42 +0000
Subject: [lm-sensors] [PATCH] I2C: SENSORS_ATXP1 must select I2C_SENSOR
Message-Id: <11211193781619@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11211193771521@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: bunk@stusta.de

[PATCH] I2C: SENSORS_ATXP1 must select I2C_SENSOR

On Thu, Jun 30, 2005 at 11:47:09PM +0200, Sebastian Pigulak wrote:
> I've tried patching linux-2.6.13-RC1 with patch-2.6.13-rc1-git2 and
> building atxp1(it allows Vcore voltage changing) into the kernel.
> Unfortunately, the kernel compilation stops with:
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

SENSORS_ATXP1 must select I2C_SENSOR.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 80efa8c72006a1c04004f8fb07b22073348e4bf2
tree 48b0d3a256790004ea5383c878f86e05f162ce31
parent 1d772e2587da3c8b0fb8610fcc1c91fd82f87e52
author Adrian Bunk <bunk@stusta.de> Fri, 01 Jul 2005 00:17:27 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:37 -0700

 drivers/i2c/chips/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -80,6 +80,7 @@ config SENSORS_ASB100
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
 	depends on I2C && EXPERIMENTAL
+	select I2C_SENSOR
 	help
 	  If you say yes here you get support for the Attansic ATXP1 VID
 	  controller.

