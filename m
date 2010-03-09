From: Phillip Pi <ant@zimage.com>
Date: Tue, 09 Mar 2010 14:20:55 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <20100309142055.GQ25106@alpha.zimage.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> > > Please be specific. What chip is it, which voltages are missing?
> >=20
> > AMD Athlon X2 939 CPU 4600+ and MSI K8N NEO4-F (MS-7125) motherboard
> > (NVIDIA nForce4). See my secondary computer details at:
> > http://alpha.zimage.com/~ant/antfarm/about/computers.txt
> >=20
> > As for voltages, Kernel 2.6.30 and earlier said something like:
> > $ sensors -f
> > k8temp-pci-00c3
> > Adapter: PCI adapter
> > Core0 Temp: +80.6=B0F
> > ...
>=20
> Please stop editing outputs. You are stripping exactly the information
> I asked for (what chip it is.)
=20
> > Adapter: ISA adapter
> > VCore: +1.12 V (min =3D +2.11 V, max =3D +2.48 V)
> > +3.3V: +3.28 V (min =3D +1.46 V, max =3D +0.21 V)
> > +5V: +4.97 V (min =3D +0.89 V, max =3D +0.22 V)
> > +12V: +11.43 V (min =3D +0.24 V, max =3D +9.67 V)
> > -12V: +0.72 V (min =3D -5.37 V, max =3D +0.63 V)
> > -5V: +5.10 V (min =3D +1.18 V, max =3D -7.66 V)
> > V5SB: +5.59 V (min =3D +0.13 V, max =3D +0.48 V)
> > VBat: +1.55 V (min =3D +2.24 V, max =3D +3.46 V)
> > fan1: 2360 RPM (min =3D 1622 RPM, div =3D 4)
> > fan2: 2376 RPM (min =3D 1985 RPM, div =3D 4)
> > temp1: +82.4=B0F (high =3D +201.2=B0F, hyst =3D +221.0=B0F) sensor =3D =

> > thermistor
> > temp2: +86.0=B0F (high =3D +176.0=B0F, hyst =3D +167.0=B0F) sensor =3D =

> > thermistor
> > beep_enable:enabled
>=20
> OK, and how do I compare this with 2.6.32 if you do not provide the
> output there?

Huh? That's all I get. Here's the 2.6.32 one:

$ sensors -f
acpitz-virtual-0
Adapter: Virtual device
temp1:       +71.2=B0F  (crit =3D +206.2=B0F)                 =20

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +91.4=B0F                                   =20
Core1 Temp:  +69.8=B0F

Where is the chip parts?

=20
> > > Remember that the output of sensors is influenced by the contents of
> > > libsensors configuration files (/etc/sensors.conf, /etc/sensors3.conf
> > > and/or /etc/sensors.d/* depending on your libsensors version and
> > > distribution choices.)
> >=20
> > I always keep my lm_sensors packages updated so whatever they gave me i=
s=20
> > what I use. The only I edited was /etc/modules based on sensors-detect =

> > results (w83627ehf). I do not recall editing sensors*.conf files or=20
> > being asked to do so.
>=20
> This doesn't mean they haven't changed. We ship a default configuration
> file, which does change over time. That being said, it does _not_
> contain arbitrary ignore statements, so should not be responsible for
> inputs mysteriously disappearing.

Hmm.
--=20
Quote of the Week: "This isn't a war. It never was a war, any more than
there's war between man and ants." --artilleryman from H.G. Wells' The
War of the Worlds
  /\___/\
 / /\ /\ \         Phil./Ant @ http://antfarm.ma.cx (Personal Web Site)
| |o   o| |                Ant's Quality Foraged Links: http://aqfl.net
   \ _ /                 E-mail: philpi@earthlink.net or ant@zimage.com
    ( )

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
