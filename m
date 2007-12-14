From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 14 Dec 2007 15:08:04 +0000
Subject: Re: [lm-sensors] k8temp weirdness, it8716 questions
Message-Id: <20071214160804.37f64973@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <475FFF23.2070800@xs4all.nl>
In-Reply-To: <475FFF23.2070800@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 14 Dec 2007 15:33:45 +0100, Udo van den Heuvel wrote:
> Jean Delvare wrote:
> > On Wed, 12 Dec 2007 16:32:51 +0100, Udo van den Heuvel wrote:
> >> I am running Fedora 8 on a Gigabyte m56s-s3 board with an AMD X2 BE-23=
50.
> >> Running sensors gives me:
> >>
> >> # sensors
> >> k8temp-pci-00c3
> >> Adapter: PCI adapter
> >> temp1:        -9=B0C
> >> temp2:       -20=B0C
> >> temp3:       -18=B0C
> >> temp4:       -14=B0C
> >>
> >> it8716-isa-0290
> (.....)
> >> in5:       +3.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> >> in6:       +0.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> >> 5VSB:      +4.92 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> >> VBat:      +3.07 V
> >> fan1:      805 RPM  (min =3D    0 RPM)
> >> fan2:        0 RPM  (min =3D    0 RPM)
> >> temp1:       +38=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   senso=
r =3D thermistor
> >> temp2:       +35=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   senso=
r =3D thermistor
> >> temp3:       +25=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   senso=
r =3D diode
> >> vid:      +1.000 V (yes, throttled down)
> >>
> >> As you can see the k8temp info is slightly off-target.
> >> Is this a known issue? How could it be corrected?
> >=20
> > The rumor says that most recent K8 CPUs have broken thermal sensors and
> > there's nothing you can do about that. My hope is that we can blacklist
> > them in the k8temp driver directly, but I don't know which models are
> > affected exactly.
>=20
> No software compensation possible?

Not that I know of. You can always apply arbitrary offsets via compute
statements in sensors.conf, but 1* you'll have to guess the offset and
2* there is no guarantee that a simple offset will do the trick. So all
in all I doubt it's worth the effort.

> (...)
> > Gigabyte are famous for their thermal sensors
> > that read 25 degrees C all the time (even though there are typically
> > thermistors, not thermal diodes.) These are unconnected thermal inputs
> > which you can just ignore.
>=20
> When temp3 is changed to thermistor it reads 89 degrees versis 24 as
> diode. (temp1/2 are 34 now)

In general you can hope that the sensor types set by the BIOS are correct.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
