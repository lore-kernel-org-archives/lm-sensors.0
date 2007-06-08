From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 08 Jun 2007 12:27:17 +0000
Subject: Re: [lm-sensors] Alerts after a power supply change
Message-Id: <20070608122717.GC3357@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <4669353B.4040400@moredata.pt>
In-Reply-To: <4669353B.4040400@moredata.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello:

* F. Fernandez <ferdez@moredata.pt> [2007-06-08 11:53:47 +0100]:
> Hi all!
>=20
> I have a machine working for months now and sensors are being monitored=20
> with nagios, with no complaints.
>=20
> Two days ago the machine started to act weird and we decided to try to=20
> change the power supply. The new one was somewhat less powerfull (300VA=20
> instead of 400VA) but it worked.
>=20
> Surprisingly, nagios informed us that there where ALARMs in the sensors. =

> We checked and it was true:
>=20
> vulcan:~# sensors
> w83627ehf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.30 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:      +12.36 V  (min =3D  +9.98 V, max =3D +13.31 V)
> AVCC:      +3.34 V  (min =3D  +1.04 V, max =3D  +3.74 V)
> 3VCC:      +3.31 V  (min =3D  +2.78 V, max =3D  +1.65 V) ALARM
> in4:       +2.04 V  (min =3D  +0.28 V, max =3D  +1.98 V) ALARM
> in5:       +1.62 V  (min =3D  +1.77 V, max =3D  +1.44 V) ALARM
> in6:       +5.20 V  (min =3D  +6.25 V, max =3D  +4.02 V) ALARM
> VSB:       +3.28 V  (min =3D  +2.40 V, max =3D  +0.93 V) ALARM
> VBAT:      +2.66 V  (min =3D  +0.66 V, max =3D  +0.80 V) ALARM
> in9:       +1.63 V  (min =3D  +1.07 V, max =3D  +0.63 V) ALARM
> Case Fan:    0 RPM  (min =3D   84 RPM, div =3D 128) ALARM
> CPU Fan:  2721 RPM  (min =3D 1004 RPM, div =3D 8)
> Aux Fan:     0 RPM  (min =3D  115 RPM, div =3D 128) ALARM
> fan4:        0 RPM  (min =3D 10546 RPM, div =3D 128) ALARM
> Sys Temp:    +35=B0C  (high =3D   +45=B0C, hyst =3D    +5=B0C)   ALARM
> CPU Temp:  +38.5=B0C  (high =3D +50.0=B0C, hyst =3D  +5.0=B0C)
> AUX Temp:  +44.5=B0C  (high =3D +55.0=B0C, hyst =3D  +5.0=B0C)
>=20
> vulcan:~#
>=20
>=20
> The machine is working all right since then, but the alarms continue. We =

> changed the power supply again, to a more powerful one, but the alarms=20
> continue.
>=20
> The label mismatch on the "sensors" command output is a bit strange. Is=20
> seems like a problem in the conf file. But we didn't touch the conf=20
> file! We just changed the power supply!
>=20
> Any suggestions will very welcome. Thanks in advance!

It looks like you are using the defaults in sensors.conf, which are probably
not correct for your mainboard.  Please take a look at the sensors.conf man
page and documentation on lm-sensors.org and then edit your config file as
necessary.  If you run into trouble while doing this, then feel free to come
back to the list with specific questions.

BTW: I have no idea why the alarms are reported now, if they weren't before.
It almost doesn't matter, because your config file clearly needs to be edit=
ed
anyway.

Regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
