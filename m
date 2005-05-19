From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: [PATCH 2.6] I2C: Sync i2c-id.h with legacy i2c project
Message-Id: <20050206143423.41eeaef1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

There is a change to include/linux/i2c-id.h in your bk-i2c tree which I
suspect breaks the new i2c-au1550 bus driver:

> diff -Nru a/include/linux/i2c-id.h b/include/linux/i2c-id.h
> --- a/include/linux/i2c-id.h	2005-02-03 18:40:18 -08:00
> +++ b/include/linux/i2c-id.h	2005-02-03 18:40:18 -08:00
> @@ -198,9 +198,8 @@
>  #define I2C_ALGO_IOP3XX	0x140000	/* XSCALE IOP3XX On-chip I2C alg */
>  #define I2C_ALGO_PCA	0x150000	/* PCA 9564 style adapters	*/
>  
> -#define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
> -#define I2C_ALGO_SGI	0x160000        /* SGI algorithm                */
> -#define I2C_ALGO_AU1550	0x170000        /* Au1550 PSC algorithm		*/
> +#define I2C_ALGO_SIBYTE 0x160000	/* Broadcom SiByte SOCs		*/
> +#define I2C_ALGO_SGI	0x170000        /* SGI algorithm                */
>  
>  #define I2C_ALGO_EXP	0x800000	/* experimental			*/
>  

Please back it out and instead apply this one, which fixes the conflict
between I2C_ALGO_SIBYTE and I2C_ALGO_PCA as well and more generally
brings values in line with the i2c-id.h file from the i2c legacy project
[1]. I've added comments about reserved IDs on both sides so as to avoid
future collisions.

Thanks.

[1] http://www2.lm-sensors.nu/~lm78/cvs/i2c/kernel/i2c-id.h

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc3-bk2/include/linux/i2c-id.h.orig	2005-02-05 19:50:47.000000000 +0100
+++ linux-2.6.11-rc3-bk2/include/linux/i2c-id.h	2005-02-06 14:20:51.000000000 +0100
@@ -20,8 +20,6 @@
     Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.		     */
 /* ------------------------------------------------------------------------- */
 
-/* $Id: i2c-id.h,v 1.68 2003/02/25 02:55:18 mds Exp $ */
-
 #ifndef LINUX_I2C_ID_H
 #define LINUX_I2C_ID_H
 
@@ -196,11 +194,13 @@
 #define I2C_ALGO_OCP    0x120000	/* IBM or otherwise On-chip I2C algorithm */
 #define I2C_ALGO_BITHS	0x130000	/* enhanced bit style adapters	*/
 #define I2C_ALGO_IOP3XX	0x140000	/* XSCALE IOP3XX On-chip I2C alg */
-#define I2C_ALGO_PCA	0x150000	/* PCA 9564 style adapters	*/
-
 #define I2C_ALGO_SIBYTE 0x150000	/* Broadcom SiByte SOCs		*/
-#define I2C_ALGO_SGI	0x160000        /* SGI algorithm                */
-#define I2C_ALGO_AU1550	0x170000        /* Au1550 PSC algorithm		*/
+#define I2C_ALGO_SGI	0x160000	/* SGI algorithm                */
+/* 0x170000 reserved for I2C_ALGO_USB, USB algorithm */
+/* 0x180000 reserved for I2C_ALGO_VIRT, Virtual bus adapter */
+#define I2C_ALGO_MV64XXX 0x190000	/* Marvell mv64xxx i2c ctlr	*/
+#define I2C_ALGO_PCA	0x1a0000	/* PCA 9564 style adapters	*/
+#define I2C_ALGO_AU1550	0x1b0000	/* Au1550 PSC algorithm		*/
 
 #define I2C_ALGO_EXP	0x800000	/* experimental			*/
 
@@ -240,6 +240,7 @@
 #define I2C_HW_B_IXP4XX 0x17	/* GPIO on IXP4XX systems		*/
 #define I2C_HW_B_S3VIA	0x18	/* S3Via ProSavage adapter		*/
 #define I2C_HW_B_ZR36067 0x19	/* Zoran-36057/36067 based boards	*/
+#define I2C_HW_B_PCILYNX 0x1a	/* TI PCILynx I2C adapter		*/
 #define I2C_HW_B_CX2388x 0x1b	/* connexant 2388x based tv cards	*/
 
 /* --- PCF 8584 based algorithms					*/


-- 
Jean Delvare
