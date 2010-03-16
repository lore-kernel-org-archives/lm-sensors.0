From: Phillip Pi <ant@zimage.com>
Date: Tue, 16 Mar 2010 19:30:11 +0000
Subject: Re: [lm-sensors] adt7473 for NVIDIA
Message-Id: <20100316193011.GV27394@alpha.zimage.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100316155203.GD25138@alpha.zimage.com>
In-Reply-To: <20100316155203.GD25138@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> > > > I noticed this kernel upgrade detected something new:=20
> > > > http://pastie.org/872083 (too long to post in here). It never detec=
ted=20
> > > > adt7473 module, but it never show it in sensors command. What is it=
?=20
> > > > From a quick Google search, it seems to be fan controls or somethin=
g?
> > >=20
> > > Hardware monitoring chip, on your graphics adapter. Getting these to
> > > work if often tedious because nVidia is not cooperating. Try the
> > > following (as root):
> > >=20
> > > # echo adt7473 0x2e > /sys/bus/i2c/devices/i2c-4/new_device
> > >=20
> > > Then "sensors" might show more.
> >=20
> > # echo adt7473 0x2e > /sys/bus/i2c/devices/i2c-4/new_device
> > # sensors
> > acpitz-virtual-0
> > Adapter: Virtual device
> > temp1:       +21.8=B0C  (crit =3D +96.8=B0C)                 =20
> >=20
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp:  +39.0=B0C                                   =20
> > Core1 Temp:  +27.0=B0C                                   =20
> >=20
> > adt7473-i2c-4-2e
> > Adapter: NVIDIA i2c adapter=20
> > in1:         +2.99 V  (min =3D  +0.00 V, max =3D  +2.99 V)  =20
> > +3.3V:       +3.21 V  (min =3D  +0.00 V, max =3D  +4.38 V)  =20
> > fan1:       1511 RPM  (min =3D    0 RPM)
> > fan2:          0 RPM  (min =3D    0 RPM)
> > fan3:          0 RPM  (min =3D  164 RPM)  ALARM
> > fan4:          0 RPM  (min =3D    0 RPM)
> > temp1:       +60.0=B0C  (low  =3D +65.0=B0C, high =3D +85.0=B0C)  ALARM=
 =20
> > Board Temp:  +53.0=B0C  (low  =3D +20.0=B0C, high =3D +60.0=B0C) =20
> > temp3:       +59.0=B0C  (low  =3D +80.0=B0C, high =3D +105.0=B0C)  ALARM
>=20
> Yes, you have to add it to some init script, otherwise you'll lose the
> device at reboot. Now the problem is that the bus number (4 in your
> case) could indeed change over time. And once again nVidia make it hard
> for us by not giving unique names to their I2C adapters, so we can't
> even select by name. All you can do is hope that the numbers won't
> change.
>=20
> WRT to the output itself, I doubt that your card has more than one fan,
> so you can probably add ignore statements for fan2, fan3 and fan4 to
> your configuration file. The rest looks reasonable.

Interesting. I exited my X and back to bash/console, and GeForce 8800
GT's sensors results are different now.

$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +21.8=B0C  (crit =3D +96.8=B0C)

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +34.0=B0C
Core1 Temp:  +21.0=B0C

adt7473-i2c-4-2e
Adapter: NVIDIA i2c adapter
in1:         +2.94 V  (min =3D  +2.94 V, max =3D  +2.94 V)   ALARM
+3.3V:       +4.31 V  (min =3D  +4.31 V, max =3D  +4.31 V)
fan1:         82 RPM  (min =3D   82 RPM)  ALARM
fan2:         82 RPM  (min =3D   82 RPM)  ALARM
fan3:         82 RPM  (min =3D   82 RPM)  ALARM
fan4:         82 RPM  (min =3D   82 RPM)  ALARM
temp1:        -5.0=B0C  (low  =3D  -5.0=B0C, high =3D  -5.0=B0C)  ALARM
Board Temp:   -5.0=B0C  (low  =3D  -5.0=B0C, high =3D  -5.0=B0C)  ALARM
temp3:        -5.0=B0C  (low  =3D  -5.0=B0C, high =3D  -5.0=B0C)  ALARM

Is that normal especially for the temperature readings?
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
