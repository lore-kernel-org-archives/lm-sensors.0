From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 12 Mar 2007 03:28:32 +0000
Subject: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <4dfa50520703112028r10911d3s3cd23d71d5899d9e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F47B44.8010108@assembler.cz>
In-Reply-To: <45F47B44.8010108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I cannot compile today, so I will report tomorrow whether the module
compiles OK and if it loads.

The sio_names[] array is the same as the names[] array:

> +static const char *sio_names[] = {
> +	"W83627EHF",
> +	"W83627EHG",
> +	"W83627DHG",
> +};

What is the difference between sio_names[] and names[] ? Why does
capitalization matter?

> +static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  {
> -	struct i2c_client *client;
>  	struct w83627ehf_data *data;
> -	struct device *dev;
> +	struct device *dev = &pdev->dev;
> +	struct w83627ehf_sio_data *sio_data = dev->platform_data;
> +	struct resource *res;
> +	static const char *names[] = {
> +		"w83627ehf",
> +		"w83627ehf",	/* treat ehg as ehf (same features) */
> +		"w83627dhg",
> +	};

It would be less code / less bytes to only use one array. If
sio_names[] and names[] are identical, sio_data->name and data->name
are the same thing as well. Am I missing something?


> @@ -83,38 +79,37 @@
>  #define SIO_ID_MASK		0xFFF0
>
>  static inline void
> -superio_outb(int reg, int val)
> +superio_outb(int reg, int val, int ioreg)
>  {
> -	outb(reg, REG);
> -	outb(val, VAL);
> +	outb(reg, ioreg + 1);

Should not be ioreg + 1 here. When I apply the patch tomorrow, I'll
manually change that to ioreg.

> +	outb(val, ioreg + 1);
>  }
>
>  static inline int
> -superio_inb(int reg)
> -{
> -	outb(reg, REG);
> -	return inb(VAL);
> +superio_inb(int reg, int ioreg)
> +{	outb(reg, ioreg);
> +	return inb(ioreg + 1);
>  }




> @@ -290,6 +288,17 @@
>  	u8 fan_stop_time[4];
>  };
>
> +/* The w83627ehf/ehg have 10 voltage inputs, but the w83627dhg has 9. This
> + * value is also used in w83627ehf_detect() to export a device name in sysfs
> + * (e.g. w83627ehf or w83627dhg) */

This comment does not apply any more. w83627ehf_device_remove_files()
and w83627ehf_probe() use data->in_num and not data->kind, but is the
correct code and does not need additional explanation. I think we can
delete the comment completely.

> +
> +struct w83627ehf_sio_data {
> +	enum kinds kind;
> +	int sioreg;	/* IO base for Super I/O */
> +	int hm_base;	/* IO base of hw monitor block */
> +	const char *name;
> +};
> +



> -static int w83627ehf_detach_client(struct i2c_client *client)
> -{
> -	struct w83627ehf_data *data = i2c_get_clientdata(client);
> -	int err;

I don't understand why int err is deleted here. Does this compile? I
have not compiled it yet.

>
> +static int __devexit w83627ehf_remove(struct platform_device *pdev)
> +{



> +	pdev = platform_device_alloc(DRVNAME, sio_data->hm_base);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> +		goto exit;
> +	}

AFAICS we don't need a goto here. Would not a return err eliminate the
goto and the exit: label below?

> -	return i2c_isa_add_driver(&w83627ehf_driver);
> +	err = platform_driver_register(&w83627ehf_driver);
> +	if (err)
> +		goto exit;
> +
> +	/* Sets global pdev as a side effect */
> +	err = w83627ehf_device_add(&sio_data);
> +	if (err)
> +		goto exit_driver;

Could also remove the goto here. goto exit could be return err. goto
exit_driver could be:

+	if (err) {
+		platform_driver_unregister(&w83627ehf_driver);
+		return err;
+	}


Hope that helps,
David


On 3/11/07, Rudolf Marek <r.marek at assembler.cz> wrote:
> Hi all,
>
> Thanks for the review. I fixed the issues. Moreover I did:
>
> 0) fixed the Kconfig - deps fixed plus now it mentions the DHG.
> 1) forgot the name attribute - so it is fixed now
> 2) removed unsigned short address * (I put that into sio_data)
> 3) removed global REG and VAL for sio access
> 4) chip w83627ehg report its name in "name" attribute as w83627ehf
>    to preserve compatibility of libsensors
> 4) changed the resource handling, platform device allocates the full 8byte
> region, and report itself there with sio name. So in my case:
>
> 0290-0297 : W83627EHG
>   0295-0296 : w83627ehf
>
> The datasheet mentions that the chip decodes just +5 and +6 but it also
> mentions
> that last three bits belong to the chip. I must check if it will hoose acpi
> pnp
> or not.
>
> David, this patch works for me, care to test it on DHG too? (Again be
> careful,
> this is very hot patch ;) Maybe you can read and check the DHG specific
> changes.
>
> Thanks,
>
> Rudolf
>
>

