From: roger@planbit.co.uk (Roger Lucas)
Date: Tue, 01 Nov 2005 19:17:53 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <20051101181659.EFD3D12E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Attached is the updated patch file for the vt8231 with kernel 2.6.14.

I believe that this has all the corrections requested by Jean in his mail
below. Thanks for reviewing it, Jean, your quick response was appreciated. 

It insmod's, runs and rmmod's OK on my Via Epia 5000 box, but it needs
testing on a wider range of machines if possible...

- Roger

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 01 November 2005 17:27
To: Roger Lucas
Cc: Rudolf Marek; LM Sensors
Subject: Re: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE
2.6

Hi Roger,

Please answer to the list rather than to me only.

> I have a patch for the vt8231 driver now (attached).  It seems OK but I
get
> a compilation warning:
> 
> drivers/hwmon/vt8231.c:63: warning: `addr_data' defined but not used
> 
> This is generated because I am using the macro
"I2C_CLIENT_INSMOD_1(vt8231)"
> to register the module, but then never use the addr_data structure that is
> created by it.
> 
> I cannot see a reason to use this structure, so I suppose I should be
using
> a different macro to register the driver...  Any thoughts ?

Don't use I2C_CLIENT_INSMOD_1. The VT8231 is not an I2C chip. It is
attached to the i2c subsystem for historical reasons, but we are trying
to separate such chips from the i2c subsystem now.

A few additional comments about your code:

> +config SENSORS_VT8231
> +	tristate "VT8231"
> +	depends on HWMON && I2C && PCI

You should make it depend on EXPERIMENTAL too.

> +/* Supports VIA VT8231 South Bridge embedded sensors 
> +**
> +** Change log:
> +**
> +**  2005-11-01: Roger Lucas (roger@planbit.co.uk)
> +**     Updated to work with the 2.6.14 kernel that I have.  This is the
first
> +**     lm-sensors port that I have done, so there may be nasty mistakes
in it.
> +**     That having been said, insmod and rmmod seem to work cleanly on my

> +**	   system and the values reported are reasonable.
> +**     I merged the Aaron Marsh vt8231 port with the most recent via686a
driver 
> +**     in the 2.6.14 kernel source to create this code.
> +**     VRM doesn't work on the Via Epia 5000 that I have as the kernel
call
> +**	   vid_which_vrm() returns -1.  Apparently the Via CPU is
unrecognised....
> +*/

Changelog doesn't belong to the code. You can add whatever comment you
want at the top of the patch, and it'll be used in the git commit.

The vid_which_vrm issue is interesting. Rudolf, can you please look
into it?

> +static int force_addr = 0;

Do not explicitely intialize static globals to 0, the compiler does it
for you.

> +MODULE_PARM(force_addr, "i");

Please use module_param instead. MODULE_PARM is deprecated.

> +static unsigned short normal_i2c[] = { I2C_CLIENT_END };

You shouldn't need this one.

> +static DEVICE_ATTR(alarms, S_IRUGO | S_IWUSR, show_alarms, NULL);

S_IWUSR is not correct, that file is read-only.

> +static DEVICE_ATTR(in0_ref, S_IRUGO, show_vid, NULL);

This attribute has been renamed to cpu0_vid.

> +        struct vt8231_data *data = vt8231_update_device(dev);

Indentation issue, you use spaces instead of a tab. Same in other
places, please fix them all.

> +	return sprintf(buf,"%ld\n", (long)data->vrm);

Please use a space after the comma. Same in other places, please fix
them all.

> +	printk("Setting VRM to \"%s\" = %d\n", buf, val );

No space before closing parenthesis.

> +	if (!request_region(isa_address, VT8231_EXTENT, "vt8231-sensors")) {

Please use the driver name to request the region.

> +	if (!(data = kmalloc(sizeof(struct vt8231_data), GFP_KERNEL))) {
> +		err = -ENOMEM;
> +		goto exit_release;
> +	}
> +
> +	memset(data, 0, sizeof(struct vt8231_data));

Please use kzalloc instead of kmalloc + memset.

> +	snprintf(new_client->name, I2C_NAME_SIZE, type_name);

strlcpy will do the same, more efficiently.

> +	/* TODO: vid and vrm */
> +       	device_create_file(&new_client->dev, &dev_attr_in0_ref);
> +	device_create_file(&new_client->dev, &dev_attr_vrm);

Bad indentation. Why this "TODO" comment?

This was only a quick and partial review, I've been reviewing too much
code today already, I'll go mad if I do more.

One last general comment: please cut long lines so that the code fits
in 80 columns.

Thanks,
-- 
Jean Delvare
