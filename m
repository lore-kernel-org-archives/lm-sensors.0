From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 00:15:34 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop unused parport i2c IDs
Message-Id: <11305336634140@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop unused parport i2c IDs

Drop unused i2c-over-parallel-port i2c IDs:
* I2C_HW_B_LPC was never actually used as far as I could search.
* I2C_HW_B_ELV and I2C_HW_B_VELLE are no more used since the
  introduction of the unified i2c-parport driver in Linux 2.6.2.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit eb00a28ae1a8fc4b3914f94ab1944396b8dda9fc
tree 002802351fdc91eacce8de3a6fe442c2299a99f0
parent cd19cc4732395eb3dbaf49042233b5ac69b1fbd3
author Jean Delvare <khali@linux-fr.org> Wed, 26 Oct 2005 21:20:17 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:13 -0700

 include/linux/i2c-id.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 44f3087..1ce4b54 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -164,10 +164,7 @@
 
 /* --- Bit algorithm adapters 						*/
 #define I2C_HW_B_LP		0x010000 /* Parallel port Philips style */
-#define I2C_HW_B_LPC		0x010001 /* Parallel port control reg. */
 #define I2C_HW_B_SER		0x010002 /* Serial line interface */
-#define I2C_HW_B_ELV		0x010003 /* ELV Card */
-#define I2C_HW_B_VELLE		0x010004 /* Vellemann K8000 */
 #define I2C_HW_B_BT848		0x010005 /* BT848 video boards */
 #define I2C_HW_B_WNV		0x010006 /* Winnov Videums */
 #define I2C_HW_B_VIA		0x010007 /* Via vt82c586b */

