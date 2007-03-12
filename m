From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 12 Mar 2007 13:06:19 +0000
Subject: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <20070312140619.b4d848c8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F47B44.8010108@assembler.cz>
In-Reply-To: <45F47B44.8010108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Sun, 11 Mar 2007 22:57:24 +0100, Rudolf Marek wrote:
> Hi all,
>=20
> Thanks for the review. I fixed the issues. Moreover I did:
>=20
> 0) fixed the Kconfig - deps fixed plus now it mentions the DHG.
> 1) forgot the name attribute - so it is fixed now

Yeah, I was bitten by this one too ;)

> 2) removed unsigned short address * (I put that into sio_data)
> 3) removed global REG and VAL for sio access

I would have prefered a separate patch for that, now it makes you patch
even larger (39 kB). Same goes for the help text updates in Kconfig.

> 4) chip w83627ehg report its name in "name" attribute as w83627ehf
>    to preserve compatibility of libsensors
> 4) changed the resource handling, platform device allocates the full 8byte
> region, and report itself there with sio name. So in my case:
>=20
> 0290-0297 : W83627EHG
>   0295-0296 : w83627ehf
>=20
> The datasheet mentions that the chip decodes just +5 and +6 but it also m=
entions
> that last three bits belong to the chip. I must check if it will hoose ac=
pi pnp
> or not.

This is a risky change. I know for a fact that some motherboards with a
W83627HF reserve 0x295-0x296 as a PNP resource, so we must not ask for
the whole 0x290-0x297 range at the device declaration level, otherwise
the driver core will reject our request. The W83627EHF might be
different but I would be surprised. As a matter of fact, see:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=ADa0c2f8fa087dc1dbc34e096c318739b1d6381a

What you are doing here is pretty much the opposite of the fix Petr
committed over a year ago. So I think you should back up this change.

I suppose that the clean fix to this problem would be to use the pnp
device when available instead of declaring our own platform device. But
I'm not familiar with pnp so I don't really know, and I also prefer
that we concentrate on killing i2c-isa for now. Further cleanups can
happen later.

As for using the Super-I/O chip name as the resource name, I considered
it, but then realized it means we need to keep these name strings in
memory forever. So I decided to use the driver name everywhere. But it
doesn't really matter, do as you wish.

> +enum kinds { w83627ehf, w83627ehg, w83627dhg };

Why define a separate kind for w83627ehg given that you treat it
everywhere as a w83627ehf? I think it's convenient that the enum matches
the prefixes used in every driver.

>  static inline int
> -superio_inb(int reg)
> -{
> -	outb(reg, REG);
> -	return inb(VAL);
> +superio_inb(int reg, int ioreg)
> +{	outb(reg, ioreg);
> +	return inb(ioreg + 1);
>  }

Bad coding style.

Also, only two drivers pass the Super-I/O base address as a parameter
to the superio functions right now (pc87360 and pc87427), and both pass
it as the first parameter, while you pass it as the last. I'd like all
drivers to use the same convention to avoid unnecessary confusion.

(Ultimately, I think we want to share all this code between all our
Super-I/O drivers to kill the redundancy and enforce the conventions.)

>  struct w83627ehf_data {
> -	struct i2c_client client;
> +	int addr;
> +	enum kinds kind;

You don't actually use "kind" anywhere.

> +struct w83627ehf_sio_data {
> +	enum kinds kind;
> +	int sioreg;	/* IO base for Super I/O */

Ideally you should not access the Super-I/O config area past the
initial detection in w83627ehf_find, so you shouldn't need to store
this value in sio_data. But I agree this can be left for a future
cleanup, it doesn't really belong to this patch. The f71805f driver
does it right already, the w83627hf driver not yet.

> +	int hm_base;	/* IO base of hw monitor block */
> +	const char *name;
> +};

I think "hwm" is a more popular abbreviation of hardware monitor.

> +static int __devinit w83627ehf_probe(struct platform_device *pdev)
>  {
> -	struct i2c_client *client;
>  	struct w83627ehf_data *data;
> -	struct device *dev;
> +	struct device *dev =3D &pdev->dev;
> +	struct w83627ehf_sio_data *sio_data =3D dev->platform_data;
> +	struct resource *res;
> +	static const char *names[] =3D {
> +		"w83627ehf",
> +		"w83627ehf",	/* treat ehg as ehf (same features) */
> +		"w83627dhg",
> +	};
>  	u8 fan4pin, fan5pin;
>  	int i, err =3D 0;
> =20
> -	if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
> -	                    w83627ehf_driver.driver.name)) {
> -		err =3D -EBUSY;
> +	if (!(data =3D kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
> +		err =3D -ENOMEM;
>  		goto exit;
>  	}
> =20
> -	if (!(data =3D kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
> -		err =3D -ENOMEM;
> -		goto exit_release;
> +	res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (!request_region(res->start + REGION_OFFSET, REGION_LENGTH,
> +			    DRVNAME)) {
> +		err =3D -EBUSY;
> +		dev_err(&pdev->dev, "Failed to request region 0x%lx-0x%lx\n",
> +			(unsigned long)(res->start + REGION_OFFSET),
> +			(unsigned long)(res->start + REGION_OFFSET + 1));
> +		goto exit_remove;
>  	}

You don't have to swap the memory allocation and the I/O resource
request. It's OK to get the memory first, and it will make you patch a
bit smaller and more readable to not change the order.

> (...)
> +exit_release_region:
> +	release_region(res->start + ADDR_REG_OFFSET, 2);
>  exit_remove:
>  	w83627ehf_device_remove_files(dev);
> -	i2c_detach_client(client);
> -exit_free:
> +	platform_set_drvdata(pdev, NULL);
>  	kfree(data);
> -exit_release:
> -	release_region(address + REGION_OFFSET, REGION_LENGTH);
>  exit:
>  	return err;
>  }

The error path doesn't look quite right to me. You can't release the
region before removing the sysfs files, it's not safe.

> +static int __init w83627ehf_find(int sioaddr, struct w83627ehf_sio_data =
*sio_data)
>  {
>  	u16 val;
> =20
> -	REG =3D sioaddr;
> -	VAL =3D sioaddr + 1;
> -	superio_enter();
> +	superio_enter(sioaddr);
> =20
> -	val =3D (superio_inb(SIO_REG_DEVID) << 8)
> -	    | superio_inb(SIO_REG_DEVID + 1);
> +	val =3D (superio_inb(SIO_REG_DEVID, sioaddr) << 8)
> +	    | superio_inb(SIO_REG_DEVID + 1, sioaddr);
>  	switch (val & SIO_ID_MASK) {
> -	case SIO_W83627DHG_ID:
> -		w83627ehf_num_in =3D 9;
> -		break;
>  	case SIO_W83627EHF_ID:
> +		sio_data->kind =3D w83627ehf;
> +		break;
>  	case SIO_W83627EHG_ID:
> -		w83627ehf_num_in =3D 10;
> +		sio_data->kind =3D w83627ehg;
> +		break;
> +	case SIO_W83627DHG_ID:
> +		sio_data->kind =3D w83627dhg;
>  		break;
>  	default:
> -		printk(KERN_WARNING "w83627ehf: unsupported chip ID: 0x%04x\n",
> +		pr_info(DRVNAME ": unsupported chip ID: 0x%04x\n",
>  			val);
> -		superio_exit();
> +		superio_exit(sioaddr);
>  		return -ENODEV;
>  	}
> =20
> -	superio_select(W83627EHF_LD_HWM);
> -	val =3D (superio_inb(SIO_REG_ADDR) << 8)
> -	    | superio_inb(SIO_REG_ADDR + 1);
> -	*addr =3D val & REGION_ALIGNMENT;
> -	if (*addr =3D 0) {
> -		superio_exit();
> +	/* we have known chip find the HWMON base */
> +
> +	sio_data->sioreg =3D sioaddr;
> +	sio_data->name =3D sio_names[sio_data->kind];
> +	superio_select(W83627EHF_LD_HWM, sio_data->sioreg);
> +	val =3D (superio_inb(SIO_REG_ADDR, sio_data->sioreg) << 8)
> +	    | superio_inb(SIO_REG_ADDR + 1, sio_data->sioreg);
> +	sio_data->hm_base =3D val & REGION_ALIGNMENT;
> +	if (sio_data->hm_base =3D 0) {
> +		superio_exit(sio_data->sioreg);
>  		return -ENODEV;
>  	}
> =20
>  	/* Activate logical device if needed */
> -	val =3D superio_inb(SIO_REG_ENABLE);
> +	val =3D superio_inb(SIO_REG_ENABLE, sio_data->sioreg);
>  	if (!(val & 0x01))
> -		superio_outb(SIO_REG_ENABLE, val | 0x01);
> +		superio_outb(SIO_REG_ENABLE, val | 0x01, sio_data->sioreg);
> =20
> -	superio_exit();
> +	superio_exit(sio_data->sioreg);
> +	pr_info(DRVNAME ": Found %s chip at %#x\n",
> +		sio_data->name, sio_data->hm_base);
>  	return 0;
>  }

I suggest adding warning messages when the base I/O isn't set and when
we need to forcibly enable the device, as I did in the w83627hf driver.
This will make support easier.

Thanks,
--=20
Jean Delvare

