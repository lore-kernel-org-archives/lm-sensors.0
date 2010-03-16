From: Phillip Pi <ant@zimage.com>
Date: Tue, 16 Mar 2010 22:33:58 +0000
Subject: Re: [lm-sensors] adt7473 for NVIDIA
Message-Id: <20100316223358.GE27394@alpha.zimage.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100316155203.GD25138@alpha.zimage.com>
In-Reply-To: <20100316155203.GD25138@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> > Interesting. I exited my X and back to bash/console, and GeForce 8800
> > GT's sensors results are different now.
> >=20
> > $ sensors
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:       +21.8=B0C  (crit =3D +96.8=B0C)
> >=20
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:  +34.0=B0C
> > Core1 Temp:  +21.0=B0C
> >=20
> > adt7473-i2c-4-2e
> > Adapter: NVIDIA i2c adapter
> > in1:         +2.94 V  (min =3D  +2.94 V, max =3D  +2.94 V)   ALARM
> > +3.3V:       +4.31 V  (min =3D  +4.31 V, max =3D  +4.31 V)
> > fan1:         82 RPM  (min =3D   82 RPM)  ALARM
> > fan2:         82 RPM  (min =3D   82 RPM)  ALARM
> > fan3:         82 RPM  (min =3D   82 RPM)  ALARM
> > fan4:         82 RPM  (min =3D   82 RPM)  ALARM
> > temp1:        -5.0=B0C  (low  =3D  -5.0=B0C, high =3D  -5.0=B0C)  ALARM
> > Board Temp:   -5.0=B0C  (low  =3D  -5.0=B0C, high =3D  -5.0=B0C)  ALARM
> > temp3:        -5.0=B0C  (low  =3D  -5.0=B0C, high =3D  -5.0=B0C)  ALARM
> >=20
> > Is that normal especially for the temperature readings?
>=20
> This is not "normal", but still expected: the I2C adapters are driven by
> your X nvidia driver, which gets inactive when you get to the console.
> This is a design flaw, the I2C buses should be working all the time,
> blame nvidia for it.

Thjanks again. I assume this problem has been like this for years. :(
--=20
Quote of the Week: "What reason, like the careful ant, draws laboriously=20
together, the wind of accident sometimes collects in a moment."=20
--Friedrich von Schiller
  /\___/\
 / /\ /\ \         Phil./Ant @ http://antfarm.ma.cx (Personal Web Site)
| |o   o| |                Ant's Quality Foraged Links: http://aqfl.net
   \ _ /                 E-mail: philpi@earthlink.net or ant@zimage.com
    ( )

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
