From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Mar 2007 10:27:52 +0000
Subject: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <20070312112752.98b38aab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F47B44.8010108@assembler.cz>
In-Reply-To: <45F47B44.8010108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Sun, 11 Mar 2007 21:28:32 -0600, David Hubbard wrote:
> Hi Rudolf,
> 
> I cannot compile today, so I will report tomorrow whether the module
> compiles OK and if it loads.
> 
> The sio_names[] array is the same as the names[] array:
> 
> > +static const char *sio_names[] = {
> > +	"W83627EHF",
> > +	"W83627EHG",
> > +	"W83627DHG",
> > +};
> 
> What is the difference between sio_names[] and names[] ? Why does
> capitalization matter?
> 
> > +static int __devinit w83627ehf_probe(struct platform_device *pdev)
> >  {
> > -	struct i2c_client *client;
> >  	struct w83627ehf_data *data;
> > -	struct device *dev;
> > +	struct device *dev = &pdev->dev;
> > +	struct w83627ehf_sio_data *sio_data = dev->platform_data;
> > +	struct resource *res;
> > +	static const char *names[] = {
> > +		"w83627ehf",
> > +		"w83627ehf",	/* treat ehg as ehf (same features) */
> > +		"w83627dhg",
> > +	};
> 
> It would be less code / less bytes to only use one array. If
> sio_names[] and names[] are identical, sio_data->name and data->name
> are the same thing as well. Am I missing something?

The upper-case strings refer to device names, the lower-case strings
refer to chip prefix as expected by libsensors. They are different
things - as a matter of fact, we use prefix w83627eh_f_ the
W83627EH_G_. It's convenient to use the same prefix for libsensors when
two chips can be handled exactly the same way, but it is still valuable
to print the exact chip name in the logs for debugging/support
purposes. 

In my w83627hf patch, I've made the upper-case strings __initdata so
they are removed from memory after driver initialization.

> > @@ -83,38 +79,37 @@
> >  #define SIO_ID_MASK		0xFFF0
> >
> >  static inline void
> > -superio_outb(int reg, int val)
> > +superio_outb(int reg, int val, int ioreg)
> >  {
> > -	outb(reg, REG);
> > -	outb(val, VAL);
> > +	outb(reg, ioreg + 1);
> 
> Should not be ioreg + 1 here. When I apply the patch tomorrow, I'll
> manually change that to ioreg.
> 
> > +	outb(val, ioreg + 1);
> >  }


Good catch.

> > -static int w83627ehf_detach_client(struct i2c_client *client)
> > -{
> > -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> > -	int err;
> 
> I don't understand why int err is deleted here. Does this compile? I
> have not compiled it yet.
> 
> > +static int __devexit w83627ehf_remove(struct platform_device *pdev)
> > +{

There's nothing which can actually fail in w83627ehf_remove, so what
would we do with "err"?

> > +	pdev = platform_device_alloc(DRVNAME, sio_data->hm_base);
> > +	if (!pdev) {
> > +		err = -ENOMEM;
> > +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> > +		goto exit;
> > +	}
> 
> AFAICS we don't need a goto here. Would not a return err eliminate the
> goto and the exit: label below?

Unified error paths are considered a good practice.

-- 
Jean Delvare

