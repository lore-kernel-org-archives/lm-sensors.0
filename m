From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 26 Sep 2005 23:21:58 +0000
Subject: [lm-sensors] [PATCH] fix functionality constant for read_byte_pec
Message-Id: <20050926232023.4cd45be5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509240308.AA01315@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200509240308.AA01315@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Konbanwa Hideki, hi all,

> Implementing read_byte_pec using read_byte_data is impossible.
> 
> SMBus read byte with PEC:
>     S Addr Rd [A] [Data] A [PEC] NA P
> 
> SMBus read byte data:
>     S Addr Wr [A] Comm [A] S Addr Rd [A] [Data] NA P
> 
> Index: i2c/kernel/i2c.h
> =================================> RCS file: /home/cvs/i2c/kernel/i2c.h,v
> retrieving revision 1.95
> diff -u -r1.95 i2c.h
> --- i2c/kernel/i2c.h	6 Sep 2005 20:08:39 -0000	1.95
> +++ i2c/kernel/i2c.h	24 Sep 2005 02:36:03 -0000
> @@ -397,6 +397,7 @@
>  #define I2C_FUNC_10BIT_ADDR		0x00000002
>  #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
>  #define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
> +#define I2C_FUNC_SMBUS_READ_BYTE_PEC	0x00000400 /* SMBus 2.0 */
>  #define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
>  #define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
>  #define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
> @@ -435,12 +436,12 @@
>                                         I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC)
>  #define I2C_FUNC_SMBUS_WORD_DATA_PEC  (I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
>                                         I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC)
> +#define I2C_FUNC_SMBUS_BYTE_PEC (I2C_FUNC_SMBUS_READ_BYTE_PEC | \
> +                                 I2C_FUNC_SMBUS_WRITE_BYTE_PEC)
>  
> -#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
>  #define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
>  #define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
>  #define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
> -#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
>  #define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
>  
>  #define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
> Index: lm_sensors2/kernel/include/i2c-dev.h
> =================================> RCS file: /home/cvs/lm_sensors2/kernel/include/i2c-dev.h,v
> retrieving revision 1.7
> diff -u -r1.7 i2c-dev.h
> --- lm_sensors2/kernel/include/i2c-dev.h	21 Jan 2003 20:01:26 -0000	1.7
> +++ lm_sensors2/kernel/include/i2c-dev.h	24 Sep 2005 02:36:03 -0000
> @@ -55,6 +55,7 @@
>  #define I2C_FUNC_10BIT_ADDR		0x00000002
>  #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
>  #define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
> +#define I2C_FUNC_SMBUS_READ_BYTE_PEC	0x00000400 /* SMBus 2.0 */
>  #define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
>  #define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
>  #define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
> @@ -93,12 +94,12 @@
>                                        I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC
>  #define I2C_FUNC_SMBUS_WORD_DATA_PEC  I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
>                                        I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC
> +#define I2C_FUNC_SMBUS_BYTE_PEC I2C_FUNC_SMBUS_READ_BYTE_PEC | \
> +                                I2C_FUNC_SMBUS_WRITE_BYTE_PEC
>  
> -#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
>  #define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
>  #define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
>  #define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
> -#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
>  #define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
>  
>  #define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \

As a consequence of the opinion I exposed yesterday, I would like to
propose a different fix: I think we should simply drop all
I2C_FUNC_SMBUS_*_PEC constants. i2c clients are not supposed to check
whether an adapter can do PEC on a specific SMBus transaction. Instead,
they should declare themselves PEC-capable (flags |= I2C_CLIENT_PEC)
and ask for the regular (non-PEC) transaction, leaving it to the bus
driver to do PEC or not.

Attached are three patches doing that: one for i2c CVS, one for
lm_sensors2 CVS and one for linux-2.6. Note that the latter should be
applied after the i2c-i801 patch I posted on this list earlier today.

In details, here's what these patches do:

i2c-func-pec-i2c-CVS.diff:
* i2c-algo-bit.c: No need to explicitely declare the ability to do
Block Process Call and Block Read with PEC.
* i2c.h: Drop I2C_FUNC_SMBUS_*_PEC constants.

i2c-func-pec-lm_sensors2-CVS.diff:
* i2c-i801.c: Rely on I2C_CLIENT_PEC to detect the PEC support in core.
No need to explicitely declare the ability to do Block Read/Write with
PEC.
* smbus-arp.c: Use a different way to detect SW PEC capabilities. It's
probably not a definitive fix, but that will do for now.
* i2c-dev.h: Drop I2C_FUNC_SMBUS_*_PEC constants.
* i2cdump.c: Do not check explictely for individual PEC transactions
support. Check for global PEC support instead. It's not reliable at
this point (which is why I made it a warning rather than an error) so
the fix isn't definitive either.

i2c-func-pec-linux-2.6.diff:
* i2c.h: Drop I2C_FUNC_SMBUS_*_PEC constants.
* i2c-i801.c: Rely on I2C_CLIENT_PEC to detect the PEC support in core.
No need to explicitely declare the ability to do Block Read/Write with
PEC.

Are there objections to this approach? If not, I'll just apply these
patches.

Note that the bug Hideki found here (read_byte_pec cannot be emulated
with read_byte_data) seems to be a proof that the design of the current
PEC implementation is broken. This implementation (or at least the
software PEC part) was relying on the fact that one transaction
"size" (really more a transaction type) would always lead to another,
unique "size" when adding PEC. Now we see that this isn't true anymore
for size = byte: the new size is byte_data for writes, and something
different (no #define yet) for reads. This means that we will need to
rewrite a part of the code if we want to support SW PEC on byte reads.
I'll work on this. My idea is that we shouldn't be considering PEC
transactions as new or reused "sizes", but as an independant flag. I'll
see what code changes are needed to do this.

Arigato/thanks,
-- 
Jean Delvare
-------------- next part --------------
Index: kernel/i2c-algo-bit.c
=================================RCS file: /home/cvs/i2c/kernel/i2c-algo-bit.c,v
retrieving revision 1.53
diff -u -r1.53 i2c-algo-bit.c
--- kernel/i2c-algo-bit.c	30 Apr 2005 19:53:50 -0000	1.53
+++ kernel/i2c-algo-bit.c	26 Sep 2005 20:55:47 -0000
@@ -534,9 +534,7 @@
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL |
 	       I2C_FUNC_10BIT_ADDR | I2C_FUNC_PROTOCOL_MANGLING |
 	       I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
-	       I2C_FUNC_SMBUS_READ_BLOCK_DATA |
-	       I2C_FUNC_SMBUS_BLOCK_PROC_CALL_PEC |
-	       I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC;
+	       I2C_FUNC_SMBUS_READ_BLOCK_DATA;
 }
 
 
Index: kernel/i2c.h
=================================RCS file: /home/cvs/i2c/kernel/i2c.h,v
retrieving revision 1.96
diff -u -r1.96 i2c.h
--- kernel/i2c.h	24 Sep 2005 09:38:17 -0000	1.96
+++ kernel/i2c.h	26 Sep 2005 20:55:48 -0000
@@ -397,10 +397,6 @@
 #define I2C_FUNC_10BIT_ADDR		0x00000002
 #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
 #define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL_PEC 0x00004000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000 
 #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000 
@@ -416,8 +412,6 @@
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2	 0x10000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
-#define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
 
 #define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
                              I2C_FUNC_SMBUS_WRITE_BYTE)
@@ -431,17 +425,6 @@
                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
 #define I2C_FUNC_SMBUS_I2C_BLOCK_2 (I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
                                     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2)
-#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC (I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
-                                       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC)
-#define I2C_FUNC_SMBUS_WORD_DATA_PEC  (I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
-                                       I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC)
-
-#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
-#define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
 
 #define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
                              I2C_FUNC_SMBUS_BYTE | \
@@ -449,7 +432,6 @@
                              I2C_FUNC_SMBUS_WORD_DATA | \
                              I2C_FUNC_SMBUS_PROC_CALL | \
                              I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
                              I2C_FUNC_SMBUS_I2C_BLOCK)
 
 /* 
-------------- next part --------------
Index: kernel/busses/i2c-i801.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-i801.c,v
retrieving revision 1.48
diff -u -r1.48 i2c-i801.c
--- kernel/busses/i2c-i801.c	26 Jun 2005 08:48:04 -0000	1.48
+++ kernel/busses/i2c-i801.c	26 Sep 2005 20:58:08 -0000
@@ -91,7 +91,7 @@
 #define PCI_DEVICE_ID_INTEL_ICH7_17	0x27da
 #endif
 
-#ifdef I2C_FUNC_SMBUS_BLOCK_DATA_PEC
+#ifdef I2C_CLIENT_PEC
 #define HAVE_PEC
 #endif
 
@@ -594,8 +594,7 @@
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
 #ifdef HAVE_PEC
-	     | (isich4 ? I2C_FUNC_SMBUS_BLOCK_DATA_PEC |
-	                 I2C_FUNC_SMBUS_HWPEC_CALC
+	     | (isich4 ? I2C_FUNC_SMBUS_HWPEC_CALC
 	               : 0)
 #endif
 #if 0
Index: kernel/chips/smbus-arp.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/smbus-arp.c,v
retrieving revision 1.14
diff -u -r1.14 smbus-arp.c
--- kernel/chips/smbus-arp.c	23 Jan 2005 18:02:43 -0000	1.14
+++ kernel/chips/smbus-arp.c	26 Sep 2005 20:58:08 -0000
@@ -184,8 +184,7 @@
 	/* must support block data w/ HW PEC or SW PEC */
 	if ((!i2c_check_functionality(adapter,
 	        I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_HWPEC_CALC)) &&
-	    (!i2c_check_functionality(adapter,
-	        I2C_FUNC_SMBUS_BLOCK_DATA_PEC)))
+	    (!i2c_check_functionality(adapter, I2C_FUNC_I2C)))
 		return(0);
 
 	if (!(data = kmalloc(sizeof(struct arp_data), GFP_KERNEL))) {
Index: kernel/include/i2c-dev.h
=================================RCS file: /home/cvs/lm_sensors2/kernel/include/i2c-dev.h,v
retrieving revision 1.9
diff -u -r1.9 i2c-dev.h
--- kernel/include/i2c-dev.h	26 Sep 2005 17:35:48 -0000	1.9
+++ kernel/include/i2c-dev.h	26 Sep 2005 20:58:08 -0000
@@ -55,10 +55,6 @@
 #define I2C_FUNC_10BIT_ADDR		0x00000002
 #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
 #define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL_PEC 0x00004000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000 
 #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000 
@@ -74,8 +70,6 @@
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2	 0x10000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
-#define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
 
 #define I2C_FUNC_SMBUS_BYTE I2C_FUNC_SMBUS_READ_BYTE | \
                             I2C_FUNC_SMBUS_WRITE_BYTE
@@ -89,17 +83,6 @@
                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
 #define I2C_FUNC_SMBUS_I2C_BLOCK_2 I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
                                    I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2
-#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC
-#define I2C_FUNC_SMBUS_WORD_DATA_PEC  I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
-                                      I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC
-
-#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
-#define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
 
 #define I2C_FUNC_SMBUS_EMUL I2C_FUNC_SMBUS_QUICK | \
                             I2C_FUNC_SMBUS_BYTE | \
@@ -107,7 +90,6 @@
                             I2C_FUNC_SMBUS_WORD_DATA | \
                             I2C_FUNC_SMBUS_PROC_CALL | \
                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                            I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
                             I2C_FUNC_SMBUS_I2C_BLOCK
 
 /* 
Index: prog/dump/i2cdump.c
=================================RCS file: /home/cvs/lm_sensors2/prog/dump/i2cdump.c,v
retrieving revision 1.35
diff -u -r1.35 i2cdump.c
--- prog/dump/i2cdump.c	25 Sep 2005 18:57:42 -0000	1.35
+++ prog/dump/i2cdump.c	26 Sep 2005 20:58:08 -0000
@@ -183,74 +183,35 @@
 
 	switch(size) {
 	case I2C_SMBUS_BYTE:
-		if (pec) {
-			if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE_PEC)) {
-				fprintf(stderr, "Error: Adapter for i2c bus "
-				        "%d does not have read w/ PEC "
-				        "capability\n", i2cbus);
-				exit(1);
-			}
-		} else {
-			if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE)) {
-				fprintf(stderr, "Error: Adapter for i2c bus "
-				        "%d does not have read capability\n",
-				        i2cbus);
-				exit(1);
-			}
+		if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE)) {
+			fprintf(stderr, "Error: Adapter for i2c bus %d does "
+				"not have read capability\n", i2cbus);
+			exit(1);
 		}
 		break;
 
 	case I2C_SMBUS_BYTE_DATA:
-		if (pec) {
-			if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC)) {
-				fprintf(stderr, "Error: Adapter for i2c bus "
-				        "%d does not have byte read w/ PEC "
-				        "capability\n", i2cbus);
-				exit(1);
-			}
-		} else {
-			if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
-				fprintf(stderr, "Error: Adapter for i2c bus "
-				        "%d does not have byte read "
-				        "capability\n", i2cbus);
-				exit(1);
-			}
+		if (!(funcs & I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
+			fprintf(stderr, "Error: Adapter for i2c bus %d does "
+				"not have byte read capability\n", i2cbus);
+			exit(1);
 		}
 		break;
 
 	case I2C_SMBUS_WORD_DATA:
-		if (pec) {
-			if (!(funcs & I2C_FUNC_SMBUS_READ_WORD_DATA_PEC)) {
-				fprintf(stderr, "Error: Adapter for i2c bus "
-				        "%d does not have word read w/ PEC "
-					"capability\n", i2cbus);
-				exit(1);
-			}
-		} else {
-			if (!(funcs & I2C_FUNC_SMBUS_READ_WORD_DATA)) {
-				fprintf(stderr, "Error: Adapter for i2c bus "
-				        "%d does not have word read "
-				        "capability\n", i2cbus);
-				exit(1);
-			}
+		if (!(funcs & I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+			fprintf(stderr, "Error: Adapter for i2c bus %d does "
+				"not have word read capability\n", i2cbus);
+			exit(1);
 		}
 		break;
 
 	case I2C_SMBUS_BLOCK_DATA:
-		if (pec) {
-			if (!(funcs & I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC)) {
-				fprintf(stderr, "Error: Adapter for i2c bus "
-				        "%d does not have smbus block read "
-					"w/ PEC capability\n", i2cbus);
-				exit(1);
-			}
-		} else {
-			if (!(funcs & I2C_FUNC_SMBUS_READ_BLOCK_DATA)) {
-				fprintf(stderr, "Error: Adapter for i2c bus "
-				        "%d does not have smbus block read "
-				        "capability\n", i2cbus);
-				exit(1);
-			}
+		if (!(funcs & I2C_FUNC_SMBUS_READ_BLOCK_DATA)) {
+			fprintf(stderr, "Error: Adapter for i2c bus %d does "
+				"not have smbus block read capability\n",
+				i2cbus);
+			exit(1);
 		}
 		break;
 
@@ -278,6 +239,10 @@
 			        strerror(errno));
 			exit(1);
 		}
+		if (!(funcs & (I2C_FUNC_SMBUS_HWPEC_CALC | I2C_FUNC_I2C))) {
+			fprintf(stderr, "Warning: Adapter for i2c bus %d does "
+			        "not seem to actually support PEC\n", i2cbus);
+		}
 	}
 
 	if (!yes) {
-------------- next part --------------
--- linux-2.6.14-rc2.orig/include/linux/i2c.h	2005-09-26 19:26:40.000000000 +0200
+++ linux-2.6.14-rc2/include/linux/i2c.h	2005-09-26 19:43:23.000000000 +0200
@@ -391,10 +391,6 @@
 #define I2C_FUNC_10BIT_ADDR		0x00000002
 #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
 #define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_READ_WORD_DATA_PEC  0x00000800 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC 0x00001000 /* SMBus 2.0 */ 
-#define I2C_FUNC_SMBUS_PROC_CALL_PEC	0x00002000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_BLOCK_PROC_CALL_PEC 0x00004000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000 
 #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000 
@@ -410,8 +406,6 @@
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK	0x08000000 /* w/ 1-byte reg. addr. */
 #define I2C_FUNC_SMBUS_READ_I2C_BLOCK_2	 0x10000000 /* I2C-like block xfer  */
 #define I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2 0x20000000 /* w/ 2-byte reg. addr. */
-#define I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC  0x40000000 /* SMBus 2.0 */
-#define I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC 0x80000000 /* SMBus 2.0 */
 
 #define I2C_FUNC_SMBUS_BYTE (I2C_FUNC_SMBUS_READ_BYTE | \
                              I2C_FUNC_SMBUS_WRITE_BYTE)
@@ -425,17 +419,6 @@
                                   I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)
 #define I2C_FUNC_SMBUS_I2C_BLOCK_2 (I2C_FUNC_SMBUS_READ_I2C_BLOCK_2 | \
                                     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK_2)
-#define I2C_FUNC_SMBUS_BLOCK_DATA_PEC (I2C_FUNC_SMBUS_READ_BLOCK_DATA_PEC | \
-                                       I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC)
-#define I2C_FUNC_SMBUS_WORD_DATA_PEC  (I2C_FUNC_SMBUS_READ_WORD_DATA_PEC | \
-                                       I2C_FUNC_SMBUS_WRITE_WORD_DATA_PEC)
-
-#define I2C_FUNC_SMBUS_READ_BYTE_PEC		I2C_FUNC_SMBUS_READ_BYTE_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_PEC		I2C_FUNC_SMBUS_WRITE_BYTE_DATA
-#define I2C_FUNC_SMBUS_READ_BYTE_DATA_PEC	I2C_FUNC_SMBUS_READ_WORD_DATA
-#define I2C_FUNC_SMBUS_WRITE_BYTE_DATA_PEC	I2C_FUNC_SMBUS_WRITE_WORD_DATA
-#define I2C_FUNC_SMBUS_BYTE_PEC			I2C_FUNC_SMBUS_BYTE_DATA
-#define I2C_FUNC_SMBUS_BYTE_DATA_PEC		I2C_FUNC_SMBUS_WORD_DATA
 
 #define I2C_FUNC_SMBUS_EMUL (I2C_FUNC_SMBUS_QUICK | \
                              I2C_FUNC_SMBUS_BYTE | \
@@ -443,7 +426,6 @@
                              I2C_FUNC_SMBUS_WORD_DATA | \
                              I2C_FUNC_SMBUS_PROC_CALL | \
                              I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                             I2C_FUNC_SMBUS_WRITE_BLOCK_DATA_PEC | \
                              I2C_FUNC_SMBUS_I2C_BLOCK)
 
 /* 
--- linux-2.6.14-rc2.orig/drivers/i2c/busses/i2c-i801.c	2005-09-26 19:36:34.000000000 +0200
+++ linux-2.6.14-rc2/drivers/i2c/busses/i2c-i801.c	2005-09-26 19:47:48.000000000 +0200
@@ -513,8 +513,7 @@
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
-	     | (isich4 ? I2C_FUNC_SMBUS_BLOCK_DATA_PEC |
-	                 I2C_FUNC_SMBUS_HWPEC_CALC
+	     | (isich4 ? I2C_FUNC_SMBUS_HWPEC_CALC
 	               : 0)
 	    ;
 }
