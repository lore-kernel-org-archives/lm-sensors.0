From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Sep 2009 06:56:28 +0000
Subject: Re: [lm-sensors] Problems with DG45ID sensors
Message-Id: <20090911085628.3c37c0cd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <11d69f10909101520u10eae0bfhe137338e336e186c@mail.gmail.com>
In-Reply-To: <11d69f10909101520u10eae0bfhe137338e336e186c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 10 Sep 2009 19:20:55 -0300, Igor Santos wrote:
> Hello,
>=20
> I've been asking for help at superuser.com, but nobody could help me.
> I've tried the last version of sensors-detect script, but it just gives me
> the same modules to load up...
>=20
> This is my computer:
> Intel Core2duo e4700
> Motherboard Intel DG45ID
> GeForce 9800 GT
> 2 HD's, one SATA and one PATA with adapter
>=20
> It tolds me to load i2c-i801, lm85 and coretemp modules. And so I did.
>=20
> I can see properly my Videocard temp (I think it's provided by nvidia,
> right?) and both HD (but sometimes the IDE disk simply goes 0=B0). My CPU
> temps looks correct too.
>=20
> But all the temps from my motherboard are zeroed.
> Take a look at the full output:
>=20
> igoru[~]$ sensors
> > lm85-i2c-0-2e
> > Adapter: SMBus I801 adapter at e000
> > V1.5: +0.00 V (min =3D +0.00 V, max =3D +3.32 V)
> > VCore: +0.00 V (min =3D +0.00 V, max =3D +2.99 V)
> > V3.3: +0.00 V (min =3D +0.00 V, max =3D +4.38 V)
> > V5: +0.00 V (min =3D +0.00 V, max =3D +6.64 V)
> > V12: +0.00 V (min =3D +0.00 V, max =3D +15.94 V)
> > CPU_Fan: 0 RPM (min =3D 0 RPM) ALARM
> > fan2: 0 RPM (min =3D 0 RPM) ALARM
> > fan3: 0 RPM (min =3D 0 RPM) ALARM
> > fan4: 0 RPM (min =3D 0 RPM) ALARM
> > CPU Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
> > Board Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
> > Remote Temp: +0.0=B0C (low =3D -127.0=B0C, high =3D +127.0=B0C)
> > cpu0_vid: +2.050 V

Looks very similar to:
http://www.lm-sensors.org/ticket/2182

Please post the output of the latest version of sensors-detect:
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

Don't forget to "rmmod lm85" before you run sensors-detect.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
