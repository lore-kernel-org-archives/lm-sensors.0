From: adobriyan@mail.ru (Alexey Dobriyan)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH] drivers/i2c/*: #include <linux/config.h> cleanup
Message-Id: <20050416181002.GA9494@mipter.zuzino.mipt.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050416184922.7c09d848.khali@linux-fr.org>
In-Reply-To: <20050416184922.7c09d848.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


-------------- next part --------------
Files that don't use CONFIG_* stuff shouldn't include config.h
Files that use CONFIG_* stuff should include config.h

It's that simple. ;-)

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>
---

 drivers/i2c/algos/i2c-algo-sibyte.c    |    1 -
 drivers/i2c/busses/i2c-ali1535.c       |    1 -
 drivers/i2c/busses/i2c-ali15x3.c       |    1 -
 drivers/i2c/busses/i2c-amd756.c        |    1 -
 drivers/i2c/busses/i2c-amd8111.c       |    1 -
 drivers/i2c/busses/i2c-au1550.c        |    1 -
 drivers/i2c/busses/i2c-elektor.c       |    1 -
 drivers/i2c/busses/i2c-frodo.c         |    1 -
 drivers/i2c/busses/i2c-i801.c          |    1 -
 drivers/i2c/busses/i2c-i810.c          |    1 -
 drivers/i2c/busses/i2c-ibm_iic.h       |    1 -
 drivers/i2c/busses/i2c-isa.c           |    1 -
 drivers/i2c/busses/i2c-ite.c           |    1 -
 drivers/i2c/busses/i2c-keywest.c       |    1 -
 drivers/i2c/busses/i2c-nforce2.c       |    1 -
 drivers/i2c/busses/i2c-parport-light.c |    1 -
 drivers/i2c/busses/i2c-parport.c       |    1 -
 drivers/i2c/busses/i2c-pca-isa.c       |    1 -
 drivers/i2c/busses/i2c-piix4.c         |    1 -
 drivers/i2c/busses/i2c-prosavage.c     |    1 -
 drivers/i2c/busses/i2c-rpx.c           |    1 -
 drivers/i2c/busses/i2c-s3c2410.c       |    1 +
 drivers/i2c/busses/i2c-savage4.c       |    1 -
 drivers/i2c/busses/i2c-sibyte.c        |    1 -
 drivers/i2c/busses/i2c-sis5595.c       |    1 -
 drivers/i2c/busses/i2c-sis630.c        |    1 -
 drivers/i2c/busses/i2c-sis96x.c        |    1 -
 drivers/i2c/busses/i2c-stub.c          |    1 -
 drivers/i2c/busses/i2c-via.c           |    1 -
 drivers/i2c/busses/i2c-viapro.c        |    1 -
 drivers/i2c/busses/i2c-voodoo3.c       |    1 -
 drivers/i2c/busses/scx200_acb.c        |    1 -
 drivers/i2c/chips/adm1021.c            |    1 -
 drivers/i2c/chips/adm1025.c            |    1 -
 drivers/i2c/chips/adm1026.c            |    1 -
 drivers/i2c/chips/ds1337.c             |    1 -
 drivers/i2c/chips/eeprom.c             |    1 -
 drivers/i2c/chips/fscher.c             |    1 -
 drivers/i2c/chips/gl518sm.c            |    1 -
 drivers/i2c/chips/it87.c               |    1 -
 drivers/i2c/chips/lm63.c               |    1 -
 drivers/i2c/chips/lm75.c               |    1 -
 drivers/i2c/chips/lm77.c               |    1 -
 drivers/i2c/chips/lm78.c               |    1 -
 drivers/i2c/chips/lm80.c               |    1 -
 drivers/i2c/chips/lm83.c               |    1 -
 drivers/i2c/chips/lm85.c               |    1 -
 drivers/i2c/chips/lm87.c               |    1 -
 drivers/i2c/chips/lm90.c               |    1 -
 drivers/i2c/chips/max1619.c            |    1 -
 drivers/i2c/chips/pc87360.c            |    1 -
 drivers/i2c/chips/via686a.c            |    1 -
 drivers/i2c/chips/w83781d.c            |    1 -
 drivers/i2c/chips/w83l785ts.c          |    1 -
 drivers/i2c/i2c-core.c                 |    1 -
 drivers/i2c/i2c-dev.c                  |    1 -
 56 files changed, 1 insertion(+), 55 deletions(-)

diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/algos/i2c-algo-sibyte.c linux-2.6.12-rc2-config.h/drivers/i2c/algos/i2c-algo-sibyte.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/algos/i2c-algo-sibyte.c	2005-04-04 16:37:52.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/algos/i2c-algo-sibyte.c	2005-04-16 17:05:29.000000000 +0000
@@ -24,7 +24,6 @@
 
 /* Ported for SiByte SOCs by Broadcom Corporation.  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-ali1535.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-ali1535.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-ali1535.c	2005-04-04 16:39:18.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-ali1535.c	2005-04-16 17:06:16.000000000 +0000
@@ -53,7 +53,6 @@
 
 /* Note: we assume there can only be one ALI1535, with one SMBus interface */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-ali15x3.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-ali15x3.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-ali15x3.c	2005-04-04 16:38:13.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-ali15x3.c	2005-04-16 17:06:29.000000000 +0000
@@ -60,7 +60,6 @@
 
 /* Note: we assume there can only be one ALI15X3, with one SMBus interface */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-amd756.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-amd756.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-amd756.c	2005-04-04 16:39:18.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-amd756.c	2005-04-16 17:06:50.000000000 +0000
@@ -37,7 +37,6 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-amd8111.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-amd8111.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-amd8111.c	2005-04-04 16:39:17.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-amd8111.c	2005-04-16 17:07:09.000000000 +0000
@@ -8,7 +8,6 @@
  * the Free Software Foundation version 2.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-au1550.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-au1550.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-au1550.c	2005-04-04 16:40:17.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-au1550.c	2005-04-16 17:07:42.000000000 +0000
@@ -27,7 +27,6 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 
-#include <linux/config.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-elektor.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-elektor.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-elektor.c	2005-04-04 16:37:51.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-elektor.c	2005-04-16 17:07:56.000000000 +0000
@@ -25,7 +25,6 @@
 /* Partialy rewriten by Oleg I. Vdovikin for mmapped support of 
    for Alpha Processor Inc. UP-2000(+) boards */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-frodo.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-frodo.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-frodo.c	2005-04-04 16:37:45.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-frodo.c	2005-04-16 17:08:07.000000000 +0000
@@ -12,7 +12,6 @@
  * version 2 as published by the Free Software Foundation.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-i801.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-i801.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-i801.c	2005-04-04 16:40:15.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-i801.c	2005-04-16 17:08:24.000000000 +0000
@@ -40,7 +40,6 @@
 
 /* Note: we assume there can only be one I801, with one SMBus interface */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-i810.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-i810.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-i810.c	2005-04-04 16:38:04.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-i810.c	2005-04-16 17:08:40.000000000 +0000
@@ -34,7 +34,6 @@
    i815			1132           
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-ibm_iic.h linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-ibm_iic.h
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-ibm_iic.h	2005-04-04 16:40:05.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-ibm_iic.h	2005-04-16 17:09:06.000000000 +0000
@@ -22,7 +22,6 @@
 #ifndef __I2C_IBM_IIC_H_
 #define __I2C_IBM_IIC_H_
 
-#include <linux/config.h>
 #include <linux/i2c.h> 
 
 struct iic_regs {
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-isa.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-isa.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-isa.c	2005-04-04 16:38:23.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-isa.c	2005-04-16 17:09:31.000000000 +0000
@@ -24,7 +24,6 @@
    the SMBus and the ISA bus very much easier. See lm78.c for an example
    of this. */
 
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-ite.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-ite.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-ite.c	2005-04-04 16:38:05.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-ite.c	2005-04-16 17:12:10.000000000 +0000
@@ -33,7 +33,6 @@
 /* With some changes from Ky?sti M?lkki <kmalkki@cc.hut.fi> and even
    Frodo Looijaard <frodol@dds.nl> */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-keywest.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-keywest.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-keywest.c	2005-04-04 16:38:58.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-keywest.c	2005-04-16 17:12:21.000000000 +0000
@@ -46,7 +46,6 @@
     sound driver to be happy
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-nforce2.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-nforce2.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-nforce2.c	2005-04-04 16:38:04.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-nforce2.c	2005-04-16 17:12:32.000000000 +0000
@@ -37,7 +37,6 @@
 
 /* Note: we assume there can only be one nForce2, with two SMBus interfaces */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-parport-light.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-parport-light.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-parport-light.c	2005-04-04 16:39:07.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-parport-light.c	2005-04-16 17:12:43.000000000 +0000
@@ -24,7 +24,6 @@
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * ------------------------------------------------------------------------ */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-parport.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-parport.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-parport.c	2005-04-04 16:38:23.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-parport.c	2005-04-16 17:13:26.000000000 +0000
@@ -24,7 +24,6 @@
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  * ------------------------------------------------------------------------ */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-pca-isa.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-pca-isa.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-pca-isa.c	2005-04-04 16:38:54.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-pca-isa.c	2005-04-16 17:13:39.000000000 +0000
@@ -17,7 +17,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-piix4.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-piix4.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-piix4.c	2005-04-04 16:38:06.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-piix4.c	2005-04-16 17:13:52.000000000 +0000
@@ -28,7 +28,6 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-prosavage.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-prosavage.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-prosavage.c	2005-04-04 16:38:07.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-prosavage.c	2005-04-16 17:14:05.000000000 +0000
@@ -54,7 +54,6 @@
  *    (Additional documentation needed :(
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/pci.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-rpx.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-rpx.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-rpx.c	2005-04-04 16:39:41.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-rpx.c	2005-04-16 17:14:17.000000000 +0000
@@ -11,7 +11,6 @@
  * changed to eliminate RPXLite references.
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-s3c2410.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-s3c2410.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-s3c2410.c	2005-04-04 16:38:07.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-s3c2410.c	2005-04-16 17:15:19.000000000 +0000
@@ -20,6 +20,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 
+#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-savage4.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-savage4.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-savage4.c	2005-04-04 16:38:13.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-savage4.c	2005-04-16 17:15:47.000000000 +0000
@@ -29,7 +29,6 @@
    it easier to add later.
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-sibyte.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-sibyte.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-sibyte.c	2005-04-04 16:39:40.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-sibyte.c	2005-04-16 17:15:57.000000000 +0000
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/i2c-algo-sibyte.h>
 #include <asm/sibyte/sb1250_regs.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-sis5595.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-sis5595.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-sis5595.c	2005-04-04 16:40:05.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-sis5595.c	2005-04-16 17:16:11.000000000 +0000
@@ -55,7 +55,6 @@
  * Add adapter resets
  */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-sis630.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-sis630.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-sis630.c	2005-04-04 16:38:06.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-sis630.c	2005-04-16 17:16:21.000000000 +0000
@@ -48,7 +48,6 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-sis96x.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-sis96x.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-sis96x.c	2005-04-04 16:38:06.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-sis96x.c	2005-04-16 17:16:32.000000000 +0000
@@ -32,7 +32,6 @@
     We assume there can only be one SiS96x with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-stub.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-stub.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-stub.c	2005-04-04 16:38:35.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-stub.c	2005-04-16 17:16:40.000000000 +0000
@@ -21,7 +21,6 @@
 
 #define DEBUG 1
 
-#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-via.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-via.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-via.c	2005-04-04 16:38:14.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-via.c	2005-04-16 17:16:50.000000000 +0000
@@ -21,7 +21,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-viapro.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-viapro.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-viapro.c	2005-04-04 16:40:16.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-viapro.c	2005-04-16 17:16:56.000000000 +0000
@@ -33,7 +33,6 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/pci.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-voodoo3.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-voodoo3.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/i2c-voodoo3.c	2005-04-04 16:38:12.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/i2c-voodoo3.c	2005-04-16 17:17:05.000000000 +0000
@@ -27,7 +27,6 @@
 /* This interfaces to the I2C bus of the Voodoo3 to gain access to
     the BT869 and possibly other I2C devices. */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/busses/scx200_acb.c linux-2.6.12-rc2-config.h/drivers/i2c/busses/scx200_acb.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/busses/scx200_acb.c	2005-04-04 16:38:13.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/busses/scx200_acb.c	2005-04-16 17:17:20.000000000 +0000
@@ -24,7 +24,6 @@
 
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/adm1021.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/adm1021.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/adm1021.c	2005-04-04 16:37:51.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/adm1021.c	2005-04-16 17:17:34.000000000 +0000
@@ -19,7 +19,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/adm1025.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/adm1025.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/adm1025.c	2005-04-04 16:37:45.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/adm1025.c	2005-04-16 17:17:42.000000000 +0000
@@ -45,7 +45,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/adm1026.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/adm1026.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/adm1026.c	2005-04-04 16:38:07.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/adm1026.c	2005-04-16 17:17:48.000000000 +0000
@@ -23,7 +23,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/ds1337.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/ds1337.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/ds1337.c	2005-04-04 16:39:05.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/ds1337.c	2005-04-16 17:17:57.000000000 +0000
@@ -13,7 +13,6 @@
  * Driver for Dallas Semiconductor DS1337 real time clock chip
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/eeprom.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/eeprom.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/eeprom.c	2005-04-04 16:38:07.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/eeprom.c	2005-04-16 17:18:05.000000000 +0000
@@ -26,7 +26,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/fscher.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/fscher.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/fscher.c	2005-04-04 16:38:13.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/fscher.c	2005-04-16 17:18:15.000000000 +0000
@@ -26,7 +26,6 @@
  *  and Philip Edelbrock <phil@netroedge.com>
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/gl518sm.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/gl518sm.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/gl518sm.c	2005-04-04 16:39:41.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/gl518sm.c	2005-04-16 17:18:27.000000000 +0000
@@ -36,7 +36,6 @@
  * 2004-01-31  Code review and approval. (Jean Delvare)
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/it87.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/it87.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/it87.c	2005-04-04 16:39:06.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/it87.c	2005-04-16 17:18:34.000000000 +0000
@@ -31,7 +31,6 @@
     type at module load time.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm63.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm63.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm63.c	2005-04-04 16:39:55.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm63.c	2005-04-16 17:18:44.000000000 +0000
@@ -37,7 +37,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm75.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm75.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm75.c	2005-04-04 16:39:55.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm75.c	2005-04-16 17:18:55.000000000 +0000
@@ -18,7 +18,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm77.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm77.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm77.c	2005-04-04 16:40:16.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm77.c	2005-04-16 17:19:02.000000000 +0000
@@ -25,7 +25,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm78.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm78.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm78.c	2005-04-04 16:39:17.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm78.c	2005-04-16 17:19:08.000000000 +0000
@@ -18,7 +18,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm80.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm80.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm80.c	2005-04-04 16:37:52.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm80.c	2005-04-16 17:19:15.000000000 +0000
@@ -21,7 +21,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm83.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm83.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm83.c	2005-04-04 16:38:12.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm83.c	2005-04-16 17:19:21.000000000 +0000
@@ -27,7 +27,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm85.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm85.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm85.c	2005-04-04 16:38:07.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm85.c	2005-04-16 17:19:29.000000000 +0000
@@ -23,7 +23,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm87.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm87.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm87.c	2005-04-04 16:39:41.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm87.c	2005-04-16 17:19:36.000000000 +0000
@@ -52,7 +52,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm90.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm90.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/lm90.c	2005-04-04 16:37:52.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/lm90.c	2005-04-16 17:19:44.000000000 +0000
@@ -70,7 +70,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/max1619.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/max1619.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/max1619.c	2005-04-04 16:39:18.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/max1619.c	2005-04-16 17:19:53.000000000 +0000
@@ -26,7 +26,6 @@
  */
 
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/pc87360.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/pc87360.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/pc87360.c	2005-04-04 16:38:05.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/pc87360.c	2005-04-16 17:20:02.000000000 +0000
@@ -33,7 +33,6 @@
  *  the standard Super-I/O addresses is used (0x2E/0x2F or 0x4E/0x4F).
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/via686a.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/via686a.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/via686a.c	2005-04-04 16:38:03.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/via686a.c	2005-04-16 17:20:10.000000000 +0000
@@ -30,7 +30,6 @@
     Warning - only supports a single device.
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/w83781d.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/w83781d.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/w83781d.c	2005-04-04 16:37:45.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/w83781d.c	2005-04-16 17:20:20.000000000 +0000
@@ -35,7 +35,6 @@
 
 */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/chips/w83l785ts.c linux-2.6.12-rc2-config.h/drivers/i2c/chips/w83l785ts.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/chips/w83l785ts.c	2005-04-04 16:40:05.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/chips/w83l785ts.c	2005-04-16 17:20:33.000000000 +0000
@@ -30,7 +30,6 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/i2c-core.c linux-2.6.12-rc2-config.h/drivers/i2c/i2c-core.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/i2c-core.c	2005-04-04 16:38:04.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/i2c-core.c	2005-04-16 17:20:44.000000000 +0000
@@ -21,7 +21,6 @@
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
    SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com>                */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
diff -uprN linux-2.6.12-rc2-vanilla/drivers/i2c/i2c-dev.c linux-2.6.12-rc2-config.h/drivers/i2c/i2c-dev.c
--- linux-2.6.12-rc2-vanilla/drivers/i2c/i2c-dev.c	2005-04-04 16:39:06.000000000 +0000
+++ linux-2.6.12-rc2-config.h/drivers/i2c/i2c-dev.c	2005-04-16 17:20:52.000000000 +0000
@@ -29,7 +29,6 @@
 /* The devfs code is contributed by Philipp Matthias Hahn 
    <pmhahn@titan.lahn.de> */
 
-#include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
