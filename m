From: Rodolfo Giometti <giometti@enneenne.com>
Date: Tue, 22 Sep 2009 08:22:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon w83627hf: add mfd support.
Message-Id: <20090922082258.GC17623@gundam.enneenne.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8469992960578062524=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1252585810-5336-2-git-send-email-giometti@linux.it>
In-Reply-To: <1252585810-5336-2-git-send-email-giometti@linux.it>
To: lm-sensors@vger.kernel.org


--===============8469992960578062524==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Content-Disposition: inline


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2009 at 04:42:49PM +0200, Samuel Ortiz wrote:
> Hi Rodolfo,
>=20
> Some comments on the MFD related parts:
>=20
> On Fri, Sep 18, 2009 at 02:09:23PM +0200, Rodolfo Giometti wrote:
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 2d50166..bc7058f 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -894,6 +894,7 @@ config SENSORS_W83L786NG
> > =20
> >  config SENSORS_W83627HF
> >  	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
> > +	depends on 83627HF
> Use select here, as the hwmon W83627HF current users are not really suppo=
sed
> to know that they have to go an manually select an obscure MFD core for t=
heir
> driver to build.
> Moreover, the symbol is MFD_W83627HF, not 83627HF.

Fixed.

> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 491ac0f..784a892 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -263,6 +263,20 @@ config EZX_PCAP
> >  	  This enables the PCAP ASIC present on EZX Phones. This is
> >  	  needed for MMC, TouchScreen, Sound, USB, etc..
> > =20
> > +config MFD_W83627HF
> > +	tristate "Winbond W83627HF, W83627THF, W83637HF, W83687THF, W83697HF"
> You must depend on MFD_CORE here.

Fixed.

> > +	help
> > +	  If you say yes here you add support for the Winbond W836X7 series
> > +	  of super-IO chips: the W83627HF, W83627THF, W83637HF, W83687THF and
> > +	  W83697HF to your platform.
> > +
> > +	  This is a multi functional device and this support defines a new
> > +	  platform device only. See other configuration submenus in order to
> > +	  enable the drivers of Winbond chip's functionalities.
> > +
> > +	  This driver can also be built as a module.  If so, the module
> > +	  will be called w83627hf-core.
> > +
> >  endmenu
> > =20
> >  menu "Multimedia Capabilities Port drivers"
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 6f8a9a1..1401ac9 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -27,6 +27,7 @@ obj-$(CONFIG_TWL4030_CORE)	+=3D twl4030-core.o twl403=
0-irq.o
> >  obj-$(CONFIG_MFD_CORE)		+=3D mfd-core.o
> > =20
> >  obj-$(CONFIG_EZX_PCAP)		+=3D ezx-pcap.o
> > +obj-$(CONFIG_MFD_W83627HF)	+=3D w83627hf-core.o
> > =20
> >  obj-$(CONFIG_MCP)		+=3D mcp-core.o
> >  obj-$(CONFIG_MCP_SA11X0)	+=3D mcp-sa11x0.o
> > diff --git a/drivers/mfd/w83627hf-core.c b/drivers/mfd/w83627hf-core.c
> > new file mode 100644
> > index 0000000..39b6190
> > --- /dev/null
> > +++ b/drivers/mfd/w83627hf-core.c
> > @@ -0,0 +1,236 @@
> > +/*
> > + *  w83627hf.c - platform device support
> > + *  Copyright (c) 2009 Rodolfo Giometti <giometti@linux.it>
> > + *
> > + *  Based on drivers/hwmon/w83627hf.c
> > + *
> > + *  Original copyright note:
> > + *    Copyright (c) 1998 - 2003  Frodo Looijaard <frodol@dds.nl>,
> > + *    Philip Edelbrock <phil@netroedge.com>,
> > + *    and Mark Studebaker <mdsxyz123@yahoo.com>
> > + *    Ported to 2.6 by Bernhard C. Schrenk <clemy@clemy.org>
> > + *    Copyright (c) 2007  Jean Delvare <khali@linux-fr.org>
> > + *
> > + *    This program is free software; you can redistribute it and/or mo=
dify
> > + *    it under the terms of the GNU General Public License as publishe=
d by
> > + *    the Free Software Foundation; either version 2 of the License, or
> > + *    (at your option) any later version.
> > + *
> > + *    This program is distributed in the hope that it will be useful,
> > + *    but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *    GNU General Public License for more details.
> > + *
> > + *    You should have received a copy of the GNU General Public License
> > + *    along with this program; if not, write to the Free Software
> > + *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/err.h>
> > +#include <linux/mutex.h>
> > +#include <linux/ioport.h>
> > +#include <linux/acpi.h>
> > +#include <linux/io.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/w83627hf.h>
> > +
> > +static u16 force_hwmon_addr;
> > +module_param(force_hwmon_addr, ushort, 0);
> > +MODULE_PARM_DESC(force_hwmon_addr,
> > +		 "Initialize the base address of the hwmon sensors");
> > +
> > +static unsigned short force_id;
> > +module_param(force_id, ushort, 0);
> > +MODULE_PARM_DESC(force_id, "Override the detected device ID");
> > +
> > +/*
> > + * Devices definitions
> > + */
> > +
> > +static struct platform_device *pdev;
> > +
> > +static char *names[] =3D {
> > +	"w83627hf",
> > +	"w83627thf",
> > +	"w83697hf",
> > +	"w83637hf",
> > +	"w83687thf",
> > +};
> > +
> > +static struct resource hwmon_res =3D {
> > +	/* .start  =3D ? - NOTE: set at runtime */
> > +	/* .end    =3D ? - NOTE: set at runtime */
> > +	.name   =3D DRVNAME "_hwmon",
> > +	.flags  =3D IORESOURCE_IO,
> > +};
> > +
> > +static struct mfd_cell cells[] =3D {
> > +	{
> > +		.name	   =3D DRVNAME "_hwmon",
> > +		.num_resources  =3D 1,
> > +		.resources      =3D &hwmon_res,
> > +	},
> > +};
> > +
> > +/*
> > + * Local functions
> > + */
> Local functions ?

Fixed.

> > +
> > +#define W627_DEVID		0x52
> > +#define W627THF_DEVID		0x82
> > +#define W697_DEVID		0x60
> > +#define W637_DEVID		0x70
> > +#define W687THF_DEVID		0x85
> > +#define WINB_ACT_REG		0x30
> > +#define WINB_BASE_REG		0x60
> Are those 2 last ones HWMON specific. If that's so, please be more specif=
ic
> about it.

Fixed.

> > +/* Constants specified below */
> > +
> > +/* Offset & size of I/O region we are interested in */
> This seems to be the hwmon region, so please be more specific about it in=
 the
> comments and in the naming below.

Fixed.

> > +#define WINB_REGION_OFFSET	5
> > +#define WINB_REGION_SIZE	2
> > +
> > +static int __init w83627hf_find(int sioaddr, unsigned short *addr,
> > +				struct w83627hf_sio_data *sio_data)
> > +{
> > +	int err =3D -ENODEV;
> > +	u16 val;
> > +
> > +	sio_data->sioaddr =3D sioaddr;
> > +
> > +	superio_enter(sio_data);
> > +	val =3D force_id ? force_id : superio_inb(sio_data, 0x20);
> > +	switch (val) {
> > +	case W627_DEVID:
> > +		sio_data->type =3D w83627hf;
> > +		break;
> > +	case W627THF_DEVID:
> > +		sio_data->type =3D w83627thf;
> > +		break;
> > +	case W697_DEVID:
> > +		sio_data->type =3D w83697hf;
> > +		break;
> > +	case W637_DEVID:
> > +		sio_data->type =3D w83637hf;
> > +		break;
> > +	case W687THF_DEVID:
> > +		sio_data->type =3D w83687thf;
> > +		break;
> > +	case 0xff:	/* No device at all */
> > +		goto exit;
> > +	default:
> > +		pr_debug(DRVNAME ": Unsupported chip (DEVID=3D0x%02x)\n", val);
> > +		goto exit;
> > +	}
> > +
> > +	sio_data->name =3D names[sio_data->type];
> > +
> > +	superio_select(sio_data, W83627HF_LD_HWM);
> > +	force_hwmon_addr &=3D (~7);
> > +	if (force_hwmon_addr) {
> > +		printk(KERN_WARNING DRVNAME ": Forcing address 0x%x\n",
> > +		       force_hwmon_addr);
> > +		superio_outb(sio_data, WINB_BASE_REG, force_hwmon_addr >> 8);
> > +		superio_outb(sio_data, WINB_BASE_REG + 1,
> > +					force_hwmon_addr & 0xff);
> > +	}
> > +	val =3D (superio_inb(sio_data, WINB_BASE_REG) << 8) |
> > +	       superio_inb(sio_data, WINB_BASE_REG + 1);
> > +	*addr =3D val & (~7);
> > +	if (*addr =3D=3D 0) {
> > +		printk(KERN_WARNING DRVNAME ": Base address not set, "
> > +		       "skipping\n");
> > +		goto exit;
> > +	}
> > +
> > +	val =3D superio_inb(sio_data, WINB_ACT_REG);
> > +	if (!(val & 0x01)) {
> > +		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
> > +		superio_outb(sio_data, WINB_ACT_REG, val | 0x01);
> > +	}
> > +
> > +	err =3D 0;
> > +	pr_info(DRVNAME ": Found %s chip at %#x\n",
> > +		names[sio_data->type], *addr);
> I'm not familiar with this chip, but although the function is called
> w83627hf_find(), it seems to me that what we're doing here is enabling the
> hwmon subdevice. Am I correct ? If that's so, could we split this functio=
n,
> and maybe even move the hwmon specific part into the hwmon driver.

Fixed.

> > + exit:
> > +	superio_exit(sio_data);
> > +	return err;
> > +}
> > +
> > +static int __init w83627hf_device_add(unsigned short address,
> > +				      const struct w83627hf_sio_data *sio_data)
> > +{
> > +	int err;
> > +
> > +	hwmon_res.start =3D address + WINB_REGION_OFFSET;
> > +	hwmon_res.end =3D address + WINB_REGION_OFFSET + WINB_REGION_SIZE - 1;
> > +
> > +	pdev =3D platform_device_alloc(DRVNAME, address);
> > +	if (!pdev) {
> > +		err =3D -ENOMEM;
> > +		printk(KERN_ERR DRVNAME ": Device allocation failed\n");
> > +		goto exit;
> > +	}
> > +
> > +	err =3D platform_device_add_data(pdev, sio_data,
> > +				       sizeof(struct w83627hf_sio_data));
> > +	if (err) {
> > +		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
> > +		goto exit_device_put;
> > +	}
> > +
> > +	err =3D platform_device_add(pdev);
> > +	if (err) {
> > +		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
> > +		       err);
> > +		goto exit_device_put;
> > +	}
> > +
> > +	err =3D mfd_add_devices(&pdev->dev, pdev->id, cells, ARRAY_SIZE(cells=
),
> > +			(struct resource *) (address & 0xffff), -1);
> > +	if (err) {
> > +		printk(KERN_ERR DRVNAME ": Cannot add sub devices (%d)\n",
> > +			err);
> > +		goto exit_device_unregister;
> > +	}
> > +
> > +	return 0;
> > +
> > +exit_device_unregister:
> > +	platform_device_unregister(pdev);
> > +exit_device_put:
> > +	platform_device_put(pdev);
> > +exit:
> > +	return err;
> > +}
> > +
> > +static int __init w83627hf_init(void)
> > +{
> > +	unsigned short address;
> > +	struct w83627hf_sio_data sio_data;
> > +
> > +	mutex_init(&sio_data.lock);
> > +
> > +	if (w83627hf_find(0x2e, &address, &sio_data)
> > +	 && w83627hf_find(0x4e, &address, &sio_data))
> > +		return -ENODEV;
> > +
> > +	/* Sets global pdev as a side effect */
> > +	return w83627hf_device_add(address, &sio_data);
> > +}
> > +
> > +static void __exit w83627hf_exit(void)
> > +{
> > +	mfd_remove_devices(&pdev->dev);
> > +	platform_device_unregister(pdev);
> > +}
> > +
> > +MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
> > +MODULE_DESCRIPTION("W83627HF platform devices definitions");
> > +MODULE_LICENSE("GPL");
> > +
> > +module_init(w83627hf_init);
> > +module_exit(w83627hf_exit);
> > diff --git a/include/linux/mfd/w83627hf.h b/include/linux/mfd/w83627hf.h
> > new file mode 100644
> > index 0000000..c9f537d
> > --- /dev/null
> > +++ b/include/linux/mfd/w83627hf.h
> > @@ -0,0 +1,112 @@
> > +/*
> > + *  w83627hf.h - platform device support, header file
> > + *  Copyright (c) 2009 Rodolfo Giometti <giometti@linux.it>
> > + *
> > + *  This program is free software; you can redistribute it and/or modi=
fy
> > + *  it under the terms of the GNU General Public License as published =
by
> > + *  the Free Software Foundation; either version 2 of the License, or
> > + *  (at your option) any later version.
> > + *
> > + *  This program is distributed in the hope that it will be useful,
> > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *  GNU General Public License for more details.
> > + *
> > + *  You should have received a copy of the GNU General Public License
> > + *  along with this program; if not, write to the Free Software
> > + *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> > + */
> > +
> > +#include <linux/mutex.h>
> > +#include <linux/io.h>
> > +
> > +#define DRVNAME "w83627hf"
> > +
> > +enum chips {
> > +	w83627hf,
> > +	w83627thf,
> > +	w83697hf,
> > +	w83637hf,
> > +	w83687thf
> > +};
> > +
> > +struct w83627hf_sio_data {
> > +	int sioaddr;
> > +	enum chips type;
> > +	char *name;
> > +
> > +	struct mutex lock;
> > +};
> > +
> > +/* logical device numbers for superio_select (below) */
> > +#define W83627HF_LD_FDC		0x00
> > +#define W83627HF_LD_PRT		0x01
> > +#define W83627HF_LD_UART1	0x02
> > +#define W83627HF_LD_UART2	0x03
> > +#define W83627HF_LD_KBC		0x05
> > +#define W83627HF_LD_CIR		0x06 /* w83627hf only */
> > +#define W83627HF_LD_GAME	0x07
> > +#define W83627HF_LD_MIDI	0x07
> > +#define W83627HF_LD_GPIO1	0x07
> > +#define W83627HF_LD_GPIO5	0x07 /* w83627thf only */
> > +#define W83627HF_LD_GPIO2	0x08
> > +#define W83627HF_LD_GPIO3	0x09
> > +#define W83627HF_LD_GPIO4	0x09 /* w83627thf only */
> > +#define W83627HF_LD_ACPI	0x0a
> > +#define W83627HF_LD_HWM		0x0b
> > +
> > +#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
> > +#define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
> > +#define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
> > +
> > +#define W83687THF_VID_EN	0x29 /* w83687thf only */
> > +#define W83687THF_VID_CFG	0xF0 /* w83687thf only */
> > +#define W83687THF_VID_DATA	0xF1 /* w83687thf only */
> > +
> > +/*
> > + * Common configuration registers access functions.
> > + *
> > + * These registers are special and they must me accessed by using a we=
ll
> > + * specified protocol. Client drivers __must__ do as follow in order to
> > + * get access correctly to these registers:
> > + *
> > + *	superio_enter()
> > + *
> > + *	superio_select()/superio_outb()/superio_inb()
> > + *
> > + *	superio_exit();
> > + *
> > + */
> > +
> > +static inline void superio_enter(struct w83627hf_sio_data *sio)
> > +{
> > +	mutex_lock(&sio->lock);
> > +
> > +	outb(0x87, sio->sioaddr);
> > +	outb(0x87, sio->sioaddr);
> I'm not really happy with this one. The unbalanced locking here makes me =
feel
> unconfortable.
>=20
> Something like that:
>=20
> void superio_outb(struct w83627hf_sio_data *sio, int ld, int reg, int val)
> {
> 	mutex_lock(&sio->lock);
>=20
> 	/* Enter */
> 	outb(0x87, sio->sioaddr)
> 	outb(0x87, sio->sioaddr)
>=20
> 	/* Select module */
> 	outb(0x07, sio->sioaddr);
> 	outb(ld, sio->sioaddr + 1);
>=20
> 	/* Write */
> 	outb(reg, sio->sioaddr);
> 	outb(val, sio->sioaddr + 1);
>=20
> 	/* Exit */
> 	outb(0xAA, sio->sioaddr);
>=20
> 	mutex_unlock(&sio->lock);
> }
>=20
> would look saner to me. I know we're wasting many IO ops here, but it see=
ms to
> me that the subdevices get to call the superio API only at init time.

This is not true for all sub-devices. GPIOs sub-device, for instance,
uses such functions to reads/writes data.

> I think it's worth it as your subdevices wouldnt have to care about follo=
wing
> these error prone steps, and you wouldnt have any more unbalanced locking
> risks.

Unluckely this not possible. Once we do superio_enter() we should be
able to do several reads and writes whose are not easily fixed in the
above function.

Clients devices must have the possibility to mix several calls of
superio_outb()/superio_inb(), so device drivers must use them properly.

> > +}
> > +
> > +static inline void superio_select(struct w83627hf_sio_data *sio, int l=
d)
> > +{
> > +	outb(0x07, sio->sioaddr);
> > +	outb(ld, sio->sioaddr + 1);
> > +}
> > +
> > +static inline void superio_outb(struct w83627hf_sio_data *sio, int reg=
, int val)
> > +{
> > +	outb(reg, sio->sioaddr);
> > +	outb(val, sio->sioaddr + 1);
> > +}
> > +
> > +static inline int superio_inb(struct w83627hf_sio_data *sio, int reg)
> > +{
> > +	outb(reg, sio->sioaddr);
> > +	return inb(sio->sioaddr + 1);
> > +}
> > +
> > +static inline void superio_exit(struct w83627hf_sio_data *sio)
> > +{
> > +	outb(0xAA, sio->sioaddr);
> > +
> > +	mutex_unlock(&sio->lock);
> > +}

I'll repropose a new patch ASAP.

Thanks,

Rodolfo

--=20

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkq4iWIACgkQQaTCYNJaVjM00QCfeeQUxR35s3/HHVD4mSstEpUA
OhAAoODkTzkIKt4lQ6iwJEvKZ8zNYS89
=9PZO
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--


--===============8469992960578062524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8469992960578062524==--
