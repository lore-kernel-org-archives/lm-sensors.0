From: David Brownell <david-b@pacbell.net>
Date: Fri, 21 Sep 2007 17:11:28 +0000
Subject: Re: [lm-sensors] [patch lm-sensors 2.10.4] i2cdetect mislabels PEC
Message-Id: <200709211011.29075.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thursday 20 September 2007, Jean Delvare wrote:

> > Right ... then your suggestion above would seem to be The Answer,
> > although rather than modify algo-bit etc I'd just add that flag
> > into I2C_FUNC_SMBUS_EMUL.  Maybe that's what you meant.
> 
> That's not what I meant, but this seems to be the right thing to do,
> yes. This should make the patch pretty simple.
> 
> > The "rename" would presumably involve leaving the old symbol around
> > for a while, deprecated so gcc warns when it's used.
> 
> Inside the kernel, we do not care. For the user-space interface through
> i2c-dev (i.e. lm-sensors' i2c-dev.h), well... I do not expect anyone to
> actually use this flag, except "i2cdetect -F". There's simply no
> real-world use case for the old semantic that bit had. So I think you
> can just rename it and be done with it.

Like this... which doesn't update "i2cdetect"

=====	CUT HERE
Rename I2C_FUNC_SMBUS_HWPEC_CALC as I2C_FUNC_SMBUS_PEC, and list that
functionality as always available through the software implementation.
Update documentation accordingly (and list similar requirements).

The way it's currently packaged doesn't present the capability in a
useful way.  Basically, it's always available -- except when the I2C
stack is running on SMBus hardware without PEC support in hardware.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 Documentation/i2c/dev-interface  |   10 +++++++---
 drivers/i2c/busses/i2c-amd8111.c |    2 +-
 drivers/i2c/busses/i2c-i801.c    |    2 +-
 include/linux/i2c.h              |    5 +++--
 4 files changed, 12 insertions(+), 7 deletions(-)

--- g26.orig/Documentation/i2c/dev-interface	2007-09-21 09:15:36.000000000 -0700
+++ g26/Documentation/i2c/dev-interface	2007-09-21 09:21:29.000000000 -0700
@@ -90,12 +90,14 @@ ioctl(file,I2C_SLAVE,long addr)
 
 ioctl(file,I2C_TENBIT,long select)
   Selects ten bit addresses if select not equals 0, selects normal 7 bit
-  addresses if select equals 0. Default 0.
+  addresses if select equals 0. Default 0.  This request is only valid
+  if the adapter has I2C_FUNC_10BIT_ADDR.
 
 ioctl(file,I2C_PEC,long select)
   Selects SMBus PEC (packet error checking) generation and verification
   if select not equals 0, disables if select equals 0. Default 0.
-  Used only for SMBus transactions.
+  Used only for SMBus transactions; only valid if the adapter has
+  I2C_FUNC_SMBUS_PEC.
 
 ioctl(file,I2C_FUNCS,unsigned long *funcs)
   Gets the adapter functionality and puts it in *funcs.
@@ -103,8 +105,10 @@ ioctl(file,I2C_FUNCS,unsigned long *func
 ioctl(file,I2C_RDWR,struct i2c_rdwr_ioctl_data *msgset)
 
   Do combined read/write transaction without stop in between.
-  The argument is a pointer to a struct i2c_rdwr_ioctl_data {
+  Only valid if the adapter has I2C_FUNC_I2C.  The argument is
+  a pointer to a
 
+  struct i2c_rdwr_ioctl_data {
       struct i2c_msg *msgs;  /* ptr to array of simple messages */
       int nmsgs;             /* number of messages to exchange */
   }
--- g26.orig/drivers/i2c/busses/i2c-amd8111.c	2007-09-21 09:10:09.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-amd8111.c	2007-09-21 09:10:21.000000000 -0700
@@ -326,7 +326,7 @@ static u32 amd8111_func(struct i2c_adapt
 		I2C_FUNC_SMBUS_BYTE_DATA |
 		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA |
 		I2C_FUNC_SMBUS_PROC_CALL | I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
-		I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_SMBUS_HWPEC_CALC;
+		I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_SMBUS_PEC;
 }
 
 static const struct i2c_algorithm smbus_algorithm = {
--- g26.orig/drivers/i2c/busses/i2c-i801.c	2007-09-21 09:10:09.000000000 -0700
+++ g26/drivers/i2c/busses/i2c-i801.c	2007-09-21 09:10:26.000000000 -0700
@@ -515,7 +515,7 @@ static u32 i801_func(struct i2c_adapter 
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
-	     | (isich4 ? I2C_FUNC_SMBUS_HWPEC_CALC : 0);
+	     | (isich4 ? I2C_FUNC_SMBUS_PEC : 0);
 }
 
 static const struct i2c_algorithm smbus_algorithm = {
--- g26.orig/include/linux/i2c.h	2007-09-21 09:07:49.000000000 -0700
+++ g26/include/linux/i2c.h	2007-09-21 09:23:42.000000000 -0700
@@ -467,7 +467,7 @@ struct i2c_msg {
 #define I2C_FUNC_I2C			0x00000001
 #define I2C_FUNC_10BIT_ADDR		0x00000002
 #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
-#define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
+#define I2C_FUNC_SMBUS_PEC		0x00000008
 #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
 #define I2C_FUNC_SMBUS_QUICK		0x00010000
 #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000
@@ -503,7 +503,8 @@ struct i2c_msg {
                              I2C_FUNC_SMBUS_WORD_DATA | \
                              I2C_FUNC_SMBUS_PROC_CALL | \
                              I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
-                             I2C_FUNC_SMBUS_I2C_BLOCK)
+			     I2C_FUNC_SMBUS_I2C_BLOCK | \
+			     I2C_FUNC_SMBUS_PEC)
 
 /*
  * Data for SMBus Messages

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
