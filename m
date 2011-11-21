From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Nov 2011 15:47:26 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm63) Fix checkpatch errors
Message-Id: <20111121164726.50c45fdc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321828936-15123-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321828936-15123-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 21 Nov 2011 18:49:23 +0530, Shubhrajyoti Datta wrote:
> Hi Guenter,
>=20
> On Mon, Nov 21, 2011 at 4:12 AM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> > =A0drivers/hwmon/lm63.c | =A0 74 +++++++++++++++++++++++++++++++++++---=
-----------
> > =A01 files changed, 53 insertions(+), 21 deletions(-)
> > (...)
> > @@ -231,11 +236,15 @@ static ssize_t set_pwm1(struct device *dev, struc=
t device_attribute *dummy,
> > =A0 =A0 =A0 =A0struct i2c_client *client =3D to_i2c_client(dev);
> > =A0 =A0 =A0 =A0struct lm63_data *data =3D i2c_get_clientdata(client);
> > =A0 =A0 =A0 =A0unsigned long val;
> > -
> > + =A0 =A0 =A0 int err;
> > +
> > =A0 =A0 =A0 =A0if (!(data->config_fan & 0x20)) /* register is read-only=
 */
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EPERM;
> >
> > - =A0 =A0 =A0 val =3D simple_strtoul(buf, NULL, 10);
> > + =A0 =A0 =A0 err =3D kstrtoul(buf, 10, &val);
> > + =A0 =A0 =A0 if (err)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> > +
> Since the valid range is upto 255 do we still need string to long ?

What else do you suggest we could use?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
