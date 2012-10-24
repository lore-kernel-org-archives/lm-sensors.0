From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 24 Oct 2012 21:14:10 +0000
Subject: Re: [lm-sensors] High pci adapter temperature
Message-Id: <20121024211409.GA15302@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <66352E8F-0EC7-454E-91CB-296A1CA83DD5@yahoo.com>
In-Reply-To: <66352E8F-0EC7-454E-91CB-296A1CA83DD5@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Oct 24, 2012 at 10:04:41AM -0400, Zhong wrote:
> Hi,
>=20
> I have recently installed Debian Squeeze on my Hp Pavilion dv6 dual booti=
ng with Windows 7, and am
> experiencing heat problems with the temperature readings produced by
> lm-sensors:=20
>=20
> root at debian:/home/zhong# sensors -f
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:      +164.3=B0F  (high =3D +158.0=B0F, crit =3D +239.9=B0F) =20
>=20
> The problem never appears in Windows.
>=20
Is the laptop's fan running ? Is it running in Windows ?=20
Do you see a temperature difference depending on the CPU load ?
What is the temperature reported in Windows ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
