From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 12 Jun 2005 12:50:28 +0000
Subject: [lm-sensors] driver for Twibright I2C2P parallel port adapter
Message-Id: <20050612125002.334f8b17.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050611114914.GA24384@kestrel>
In-Reply-To: <20050611114914.GA24384@kestrel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karel,

> After sending to Jean Delvare, maintainer written in i2c-parports.c,
> I was told to rewrite it. I rewrote the following:
> 1) As the device needs three distinctive outs to initialize, the
>    initializataion was rewritten from .init, .init2 and .init3 to
>    more general zero-terminated list.

Looks good. Maybe we can even initialize them inside adapter_parm rather
than outside. I just posted a query to LKML, we'll see what they say.

> 2) make menuconfig [Help] was improved

I think you are misusing this place. There are three places where help
can be added:
* configuration menu
* module info
* documentation file (Documentation/i2c/busses/i2c-parport)

The first one should hold the necessary information for users to decide
whether they need this driver or not. The second one should hold the
necessary information for people to know how they should load the
driver. The third one should hold the rest.

I think my driver and its documentation file match these goals just
fine, so I would invite you to not change that and simply add a list
item for your new adapter where needed. Any specific information you
would like to about this adapter belongs to
Documentation/i2c/busses/i2c-parport.

> 3) Instead of decreasing timeout constant from 1s to 10ms (because
>    with 1s constant it was generating 90s delay on pcf8591 module load
>    when the adapter's optically isolated half was unpowered), I
>    rewrote the i2c-algo-bit.c to check for -ETIMEDOUT propagating from
>    sclhi() upwards, and decreased the constant from 1s to only 500ms.

I don't think it's worth changing. With the change made to i2c-algo-bit,
the delay will be down from 90 seconds to 1 second. I don't think one
less half second will make any difference. Keep in mind that loading
drivers for devices which are powered down or otherwise unreachable is
not correct anyway, so I cannot change the timeout value to help you do
so.

> Please look at the driver and either tell me what needs to be redone
> or incorporate it into the kernel.

Comments inline.

> --- /usr/src/linux-2.6.11.9/drivers/i2c/busses/Kconfig	2005-05-12 00:42:53.000000000 +0200
> +++ busses/Kconfig	2005-05-29 14:05:15.000000000 +0200

Please create patches which I can apply with patch -p1.

> @@ -246,9 +246,10 @@
>  	select I2C_ALGOBIT
>  	help
>  	  This supports parallel port I2C adapters such as the ones made by
> -	  Philips or Velleman, Analog Devices evaluation boards, and more.
> -	  Basically any adapter using the parallel port as an I2C bus with
> -	  no extra chipset is supported by this driver, or could be.
> +	  Philips or Velleman, Analog Devices evaluation boards, Twibright
> +	  I2C2P, and more. Basically any adapter using the parallel port as an
> +	  I2C bus with no extra chipset is supported by this driver, or could
> +	  be.
>  
>  	  This driver is a replacement for (and was inspired by) an
>  	  older driver named i2c-philips-par.  The new driver supports
>  	  more devices,

OK.

> @@ -261,6 +262,35 @@
>  	  This support is also available as a module.  If so, the module
>  	   will be called i2c-parport.
>  
> +	  Supported adapters
> +	  =========
> +	  type	description
> +	  -----------------
> +	  0	Philips adapter
> +	  1	home brew teletext adapter
> +	  2 	Velleman K8000 adapter
> +	  3	ELV adapter
> +	  4	ADM1032 evaluation board
> +	  5	ADM1025, ADM1030 and ADM1031 evaluation boards
> +	  6	Twibright I2C2P adapter http://i2c2p.twibright.com
> +
> +	  Setting adapter type
> +	  ==========
> +	  If this driver is hard-compiled in kernel, add i2c_parport.type=<type
> +	  number from table above> to your append string in boot loader
> +	  (separate by space if something is already there).
> +
> +	  If this driver is selected as module, use module option (parameter)
> +	  "type=<type number from table above>" (without quotes) for insmod or
> +	  modprobe.
> +
> +	  Note
> +	  ==
> +	  If I2C2P adapter has not it's optically separated output half
> +	  powered, SDA/SCL readback will not work, initialization will fail and
> +	  couple seconds delay will be introduced on kernel boot or module
> +	  insertion. This doesn't indicate driver malfunction.
> +
>  config I2C_PARPORT_LIGHT
>  	tristate "Parallel port adapter (light)"
>  	depends on I2C

All this stuff belongs to Documentation/i2c/busses/i2c-parport.

> --- /usr/src/linux-2.6.11.9/drivers/i2c/busses/i2c-parport.c	2005-05-12 00:42:10.000000000 +0200
> +++ busses/i2c-parport.c 2005-06-11 13:23:08.000000000 +0200
> @@ -131,7 +132,7 @@
>  /* Encapsulate the functions above in the correct structure.
>     Note that this is only a template, from which the real structures are
>     copied. The attaching code will set getscl to NULL for adapters that
> -   cannot read SCL back, and will also make the the data field point to
> +   cannot read SCL back, and will also make the data field point to
>     the parallel port structure. */
>  static struct i2c_algo_bit_data parport_algo_data = {
>  	.setsda		= parport_setsda,

This typo is already fixed in the latest kernel trees.

> @@ -140,7 +141,12 @@
>  	.getscl		= parport_getscl,
>  	.udelay		= 60,
>  	.mdelay		= 60,
> -	.timeout	= HZ,
> +	.timeout	= (HZ+1)/2,
> +			/* This is 500ms rounded upwards.
> +			 * Parport adapter of type 6 may be
> +			 * powered down which introduces a delay to
> +			 * machine boot. Therefore it's sensible to keep
> +			 * this timeout reasonably low. */
>  }; 
>  
>  /* ----- I2c and parallel port call-back functions and structures --------- */

Not useful IMHO.

> @@ -152,6 +158,22 @@
>  	.name		= "Parallel port adapter",
>  };
>  
> +/* up=1 means start and up=0 stop. Also does a wait after init (and no wait
+ * on deinit). */
> +static void start_stop_adapter(struct parport *port,
> +		struct adapter_parm* adap, int up)
> +{
> +	struct lineop *p = adap->init;
> +
> +	if (p) while (p->val){
> +		line_set(port, up, p);
> +		p++;
> +	}
> +
> +	if (up&&adap->msleep)
> +		msleep_interruptible(adap->msleep);
> +}

Watch your coding style. "if" and "while" should be on separate lines,
add space before the opening parenthesis, spaces around "&&".

> @@ -188,8 +210,7 @@
>  	parport_setsda(port, 1);
>  	parport_setscl(port, 1);
>  	/* Other init if needed (power on...) */
> -	if (adapter_parm[type].init.val)
> -		line_set(port, 1, &adapter_parm[type].init);
> +	start_stop_adapter(port,adapter_parm+type,1);

Add a space after each comma please.

>  
>  	parport_release(adapter->pdev);
>  
> @@ -218,8 +239,7 @@
>  	     prev = adapter, adapter = adapter->next) {
>  		if (adapter->pdev->port = port) {
>  			/* Un-init if needed (power off...) */
> -			if (adapter_parm[type].init.val)
> -				line_set(port, 0, &adapter_parm[type].init);
> +			start_stop_adapter(port, adapter_parm+type,0);

Ditto.

> --- /usr/src/linux-2.6.11.9/drivers/i2c/busses/i2c-parport.h	2005-05-12 00:43:48.000000000 +0200
> +++ busses/i2c-parport.h 2005-06-11 13:29:17.000000000 +0200
> @@ -37,28 +37,47 @@
>  	struct lineop setscl;
>  	struct lineop getsda;
>  	struct lineop getscl;
> -	struct lineop init;
> +	int msleep;		/* Milliseconds to wait after init */
> +	struct lineop* init;	/* Zero-terminated list, where an entry with
> +				   zero .val serves as terminator. */
>  };

I don't much like the "msleep" name. It doesn't show what the value is
for. Not sure I can find a better name though... "initsleep" maybe?

>  
> +static struct lineop adm1032_init[] = {
> +				{ 0xf0, DATA, 0},
> +				{ 0, 0, 0}, /* End */
> +			  };

You can terminate the list with only "{ 0 }".

>  static struct adapter_parm adapter_parm[] = {
>  	/* type 0: Philips adapter */
>  	{
> -		.setsda	= { 0x80, DATA, 1 },
> -		.setscl	= { 0x08, CTRL, 0 },
> -		.getsda	= { 0x80, STAT, 0 },
> -		.getscl	= { 0x08, STAT, 0 },
> +		.setsda = { 0x80, DATA, 1 },
> +		.setscl = { 0x08, CTRL, 0 },
> +		.getsda = { 0x80, STAT, 0 },
> +		.getscl = { 0x08, STAT, 0 },

Gnii? Don't change that please.

> +		.msleep = 0,
> +		.init=NULL,
>  	},

You do not need to initialize 0 and NULL fields of static structures,
the compiler will do it for you (and probably more efficiently).

> +	/* type 6: Twibright I2C2P adapter */
> +	{
> +		.setsda = { 0x01, CTRL, 1},
> +		.getsda = { 0x80, STAT, 1},
> +		.setscl = { 0x08, CTRL, 1},
> +		.getscl = { 0x40, STAT, 0},
> +		.msleep = 100,
> +		.init	= i2c2p_init,
>  	},
>  };

Please use tabs before the equals sign.

> @@ -91,4 +124,6 @@
>  	" 2 = Velleman K8000 adapter\n"
>  	" 3 = ELV adapter\n"
>  	" 4 = ADM1032 evaluation board\n"
> -	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n");
> +	" 5 = ADM1025, ADM1030 and ADM1031 evaluation boards\n"
> +	" 6 = Twibright I2C2P adapter\n"
> +	"See [Help] in make menuconfig for more info.");

No. You can't ask the user to go run make menuconfig, while chances are
the user doesn't even has the sources of his kernel available - and if
he/she has, you can ask him/her to go run make menuconfig to see runtime
documentation. This is the reason why such documentation belongs to
Documentation/i2c, as I said before.

And one more thing: your patch breaks i2c-parport-light. Both
i2c-parport and i2c-parport-light include the i2c-parport.h file, so any
data structure change there must be reflected in both drivers.

Thanks,
-- 
Jean Delvare
