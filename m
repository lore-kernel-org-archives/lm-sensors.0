From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Feb 2011 15:56:06 +0000
Subject: Re: [lm-sensors] f75375s detected but no temp output
Message-Id: <20110206165606.063ea575@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
In-Reply-To: <AANLkTimosNm7_k9scygyWZuWZPunJ=wteQ+UgFB2-Gn8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 6 Feb 2011 11:41:35 +0100, Pali Roh=E1r wrote:
> 2011/1/6 Jean Delvare <khali@linux-fr.org>:
> > On Sat, 25 Dec 2010 14:15:46 +0100, Pali Roh=E1r wrote:
> >> Where is the problem? And why is no f75375s temp detected by lm sensor=
s?
> >
> > Nvidia binary driver, right? It misses four lines of code that would let
> > hwmon drivers bind to its I2C adapters. The code exists for 4 or 5
> > years now, it's even included in Gentoo [1] but Nvidia never bothered
> > applying it. Complain to them.
> >
> > [1] http://gentoo.zugaina.org/portage/x11-drivers/nvidia-drivers/files/=
NVIDIA_i2c-hwmon.patch
> >
> > --
> > Jean Delvare
> >
>=20
> Yes, I'm using nvidia binary driver. I applied this patch on nvidia
> driver but still does not working (same problem). I checked
> I2C_CLASS_HWMON is defined to (1<<0)

In fact it looks like your hwmon chip is not on the same bus as other
graphics cards, so you should drop the (port =3D 2) test in the patch,
and just set pI2cAdapter->class =3D I2C_CLASS_HWMON for all adapters.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
