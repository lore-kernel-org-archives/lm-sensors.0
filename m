From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 23 Sep 2007 21:01:27 +0000
Subject: Re: [lm-sensors] [patch lm-sensors 2.10.4] i2cdetect mislabels PEC
Message-Id: <20070923230127.0317c4de@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Fri, 21 Sep 2007 10:11:28 -0700, David Brownell wrote:
> Like this... which doesn't update "i2cdetect"
> 
> =====	CUT HERE
> Rename I2C_FUNC_SMBUS_HWPEC_CALC as I2C_FUNC_SMBUS_PEC, and list that
> functionality as always available through the software implementation.
> Update documentation accordingly (and list similar requirements).
> 
> The way it's currently packaged doesn't present the capability in a
> useful way.  Basically, it's always available -- except when the I2C
> stack is running on SMBus hardware without PEC support in hardware.

Actually, except when the driver does not support it (drivers could lack
PEC support while the hardware can do it.) Such drivers are frequent
on PC hardware: the popular i2c-piix4 and i2c-viapro drivers do not
have PEC support. In fact, only nVidia and recent Intel chips have PEC
supported. So, what seems to be the exception from your embedded point
of view (where SMBus is most often emulated on top of I2C), isn't
really.

> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  Documentation/i2c/dev-interface  |   10 +++++++---
>  drivers/i2c/busses/i2c-amd8111.c |    2 +-
>  drivers/i2c/busses/i2c-i801.c    |    2 +-
>  include/linux/i2c.h              |    5 +++--
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> --- g26.orig/Documentation/i2c/dev-interface	2007-09-21 09:15:36.000000000 -0700
> +++ g26/Documentation/i2c/dev-interface	2007-09-21 09:21:29.000000000 -0700
> @@ -90,12 +90,14 @@ ioctl(file,I2C_SLAVE,long addr)
>  
>  ioctl(file,I2C_TENBIT,long select)
>    Selects ten bit addresses if select not equals 0, selects normal 7 bit
> -  addresses if select equals 0. Default 0.
> +  addresses if select equals 0. Default 0.  This request is only valid
> +  if the adapter has I2C_FUNC_10BIT_ADDR.
>  
>  ioctl(file,I2C_PEC,long select)
>    Selects SMBus PEC (packet error checking) generation and verification
>    if select not equals 0, disables if select equals 0. Default 0.
> -  Used only for SMBus transactions.
> +  Used only for SMBus transactions; only valid if the adapter has
> +  I2C_FUNC_SMBUS_PEC.

Not correct. PEC being optional, chip drivers (or i2c-dev users) can
declare themselves PEC-compliant and let the adapter driver decide
whether it can actually do PEC or not. This is the right way to do it.
So a better wording would be "only has an effect if..."

>  
>  ioctl(file,I2C_FUNCS,unsigned long *funcs)
>    Gets the adapter functionality and puts it in *funcs.
> @@ -103,8 +105,10 @@ ioctl(file,I2C_FUNCS,unsigned long *func
>  ioctl(file,I2C_RDWR,struct i2c_rdwr_ioctl_data *msgset)
>  
>    Do combined read/write transaction without stop in between.
> -  The argument is a pointer to a struct i2c_rdwr_ioctl_data {
> +  Only valid if the adapter has I2C_FUNC_I2C.  The argument is
> +  a pointer to a
>  
> +  struct i2c_rdwr_ioctl_data {
>        struct i2c_msg *msgs;  /* ptr to array of simple messages */
>        int nmsgs;             /* number of messages to exchange */
>    }
> --- g26.orig/drivers/i2c/busses/i2c-amd8111.c	2007-09-21 09:10:09.000000000 -0700
> +++ g26/drivers/i2c/busses/i2c-amd8111.c	2007-09-21 09:10:21.000000000 -0700
> @@ -326,7 +326,7 @@ static u32 amd8111_func(struct i2c_adapt
>  		I2C_FUNC_SMBUS_BYTE_DATA |
>  		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA |
>  		I2C_FUNC_SMBUS_PROC_CALL | I2C_FUNC_SMBUS_BLOCK_PROC_CALL |
> -		I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_SMBUS_HWPEC_CALC;
> +		I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_SMBUS_PEC;
>  }
>  
>  static const struct i2c_algorithm smbus_algorithm = {
> --- g26.orig/drivers/i2c/busses/i2c-i801.c	2007-09-21 09:10:09.000000000 -0700
> +++ g26/drivers/i2c/busses/i2c-i801.c	2007-09-21 09:10:26.000000000 -0700
> @@ -515,7 +515,7 @@ static u32 i801_func(struct i2c_adapter 
>  	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
>  	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
>  	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK
> -	     | (isich4 ? I2C_FUNC_SMBUS_HWPEC_CALC : 0);
> +	     | (isich4 ? I2C_FUNC_SMBUS_PEC : 0);
>  }
>  
>  static const struct i2c_algorithm smbus_algorithm = {
> --- g26.orig/include/linux/i2c.h	2007-09-21 09:07:49.000000000 -0700
> +++ g26/include/linux/i2c.h	2007-09-21 09:23:42.000000000 -0700
> @@ -467,7 +467,7 @@ struct i2c_msg {
>  #define I2C_FUNC_I2C			0x00000001
>  #define I2C_FUNC_10BIT_ADDR		0x00000002
>  #define I2C_FUNC_PROTOCOL_MANGLING	0x00000004 /* I2C_M_{REV_DIR_ADDR,NOSTART,..} */
> -#define I2C_FUNC_SMBUS_HWPEC_CALC	0x00000008 /* SMBus 2.0 */
> +#define I2C_FUNC_SMBUS_PEC		0x00000008
>  #define I2C_FUNC_SMBUS_BLOCK_PROC_CALL	0x00008000 /* SMBus 2.0 */
>  #define I2C_FUNC_SMBUS_QUICK		0x00010000
>  #define I2C_FUNC_SMBUS_READ_BYTE	0x00020000
> @@ -503,7 +503,8 @@ struct i2c_msg {
>                               I2C_FUNC_SMBUS_WORD_DATA | \
>                               I2C_FUNC_SMBUS_PROC_CALL | \
>                               I2C_FUNC_SMBUS_WRITE_BLOCK_DATA | \
> -                             I2C_FUNC_SMBUS_I2C_BLOCK)
> +			     I2C_FUNC_SMBUS_I2C_BLOCK | \
> +			     I2C_FUNC_SMBUS_PEC)
>  
>  /*
>   * Data for SMBus Messages

Rest of the patch looks all right, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
