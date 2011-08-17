From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 17 Aug 2011 06:24:00 +0000
Subject: Re: [lm-sensors] Alix 2D2
Message-Id: <20110817062400.GA11981@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E4A9BEE.5030108@sysnux.pf>
In-Reply-To: <4E4A9BEE.5030108@sysnux.pf>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Aug 17, 2011 at 01:25:55AM -0400, Jean-Denis Girard wrote:
> Hi,
>=20
> Le 16/08/2011 06:47, Guenter Roeck a =E9crit :
> > First question is what you mean with "for some time now". days ? weeks ?
> > months ? years ? since 3.0 ? 2.6.39 ? 2.4.16 ?
>=20
> Unfortunately I don't know, but it is more than one year. It did work in
> 2.6.32.2, I'm sure it didn't work in 2.6.38, 2.6.39.
>=20
> > Would be great if you can point to the most recent working kernel.
>=20
> Sorry, I didn't notice when it stopped to work.
>=20
> >=20
> > Second, please provide output of "i2cdetect 0" (i2c-dev needs to be
> > loaded for this to work). That should show us if the sensor is still
> > detected on the i2c bus.
>=20
> [admin@ix100 ~]$ sudo i2cdetect 0
> Error: Could not open file `/dev/i2c-0': No such device
>=20
> >=20
> > If it is, please also provide output of "i2cdump 0 0x4c".
> >=20
> > For the lm90 module, please make sure that it is really loaded. You can
> > verify this with the "lsmod" command.
>=20
> lsmod gives:
> Module                  Size  Used by
> lm90                    7852  0
> i2c_dev                 3324  0
> scx200_acb              3388  0
> ...
>=20
> This is what I see in my logs
> i2c /dev entries driver
> i2c-core: driver [lm90] registered
>=20

Looks like the i2c adapter is not recognized. Do you see anything in /sys/c=
lass/i2c-adapter ?

Looking into the i2c bus driver code, it was recently converted into a plat=
form driver.
The supporting mfd driver would be cs5535-mfd. That might be one possible r=
eason
for your problem, though it happened less than a year ago.

There have been other changes over time; since you don't know when the prob=
lem started,
it will be quite difficult if not impossible to track down the problem. You=
 may have to
do some trials with different kernel versions to identify when the problem =
was introduced,
and then do some development work and use bisect to track down the actual c=
ommit.

Anyway, this is quite obviously a i2c bus driver problem, meaning you are o=
n the wrong
mailing list. i2c issues should be discussed on linux-i2c@vger.kernel.org.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
