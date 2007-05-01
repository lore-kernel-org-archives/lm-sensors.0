From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 01 May 2007 03:30:20 +0000
Subject: Re: [lm-sensors] [PATCH] Add LM93 support
Message-Id: <20070501033020.GA31332@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704131723.42773.hjk@linutronix.de>
In-Reply-To: <200704131723.42773.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans:

> Am Montag 30 April 2007 06:07 schrieb Mark M. Hoffman:
> > First: would you like to add an entry to MAINTAINERS for this driver, p=
ointing
> > to yourself?  Although I wrote the original, I no longer have access to=
 the
> > hardware.

* Hans-J=FCrgen Koch <hjk@linutronix.de> [2007-04-30 11:56:34 +0200]:
> I have a similar problem. The hardware I'm testing with now is not my pro=
perty,
> I'll have to give it back one day. I'm thinking about building a i2c_parp=
ort
> adapter where I can attach sensors chips. Dunno yet if this is feasible. =
If
> I have a LM93 available permanently, I have no problems with becoming its
> driver's maintainer. But I don't want to add myself to MAINTAINERS before=
 that
> is the case.

It's not too difficult to build one of those.  Or if you can solder fine pi=
tch,
you can fly some wires off of a DIMM for SCL/SDA.  Or search the i2c archiv=
es
for a USB->I2C device designed by Till Harbaum (sp?).

Anyway, it's up to you if you want to patch yourself into MAINTAINERS or no=
t.
=20
> >=20
> > (some hours later)  Wow, I forgot how *enormous* this driver is relativ=
e to
> > other hwmon drivers.  I was not able to review it completely today; any=
way,
> > here is what I have for you, for now.  Thanks for your patience.  Review
> > comments inline...
>=20
> Allright, first iteration. I've attached a new version of the patch with
> the modifications you mentioned.=20

You missed some of my comments near the bottom of the driver source:

> +	err =3D PTR_ERR(data->class_dev);
> +	dev_err(&client->dev, "error registering hwmon device.\n");
> +	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
> +err_detach:
> +	i2c_detach_client(client);
> +err_free:
> +	kfree(client);

kfree(data);

> +err_out:
> +	return err;
> +}
> +
> +/* This function is called when:
> +     * lm93_driver is inserted (when this module is loaded), for each
> +       available adapter
> +     * when a new adapter is inserted (and lm93_driver is still present)=
 */
> +static int lm93_attach_adapter(struct i2c_adapter *adapter)
> +{
> +	return i2c_probe(adapter, &addr_data, lm93_detect);
> +}
> +
> +static int lm93_detach_client(struct i2c_client *client)
> +{
> +	struct lm93_data *data =3D i2c_get_clientdata(client);
> +	int err =3D 0;
> +
> +	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
> +	hwmon_device_unregister(data->class_dev);
> +

The hwmon_device_unregister() should precede the sysfs_remove_group().

> +	err =3D i2c_detach_client(client);
> +	if (!err)
> +		kfree(client);

kfree(data);

> +	return err;
> +}
> +
> +static int __init lm93_init(void)
> +{
> +	return i2c_add_driver(&lm93_driver);
> +}

Regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
