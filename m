From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 08 Aug 2007 01:03:16 +0000
Subject: Re: [lm-sensors] bad temperature values from w83781d in 2.6.22
Message-Id: <20070808010316.GB3584@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070805183219.0d54802b.akpm@linux-foundation.org>
In-Reply-To: <20070805102604.GA9123@sommrey.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Joerg Sommrey <jo@sommrey.de>
Cc: LKML <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Joerg:

(I tried to follow-up using the gmane.org mail/news gateway... didn't seem
to work.)

* Joerg Sommrey <jo@sommrey.de> [2007-08-05 12:26:04 +0200]:
> Hi,
>=20
> after upgrading from 2.6.21 to 2.6.22 the CPU temperatures shown by
> w83781d look unreal.  They were in a range from 40=B0C when idle to
> 75=B0C under full load with 2.6.21.  The values shown now are in a very
> small range from 77=B0C to 82=B0C.  From the (low) noise of the fan I can
> tell that the temperature is <50=B0C.
> The third temperature shown is completely wrong.
>=20
> I have a Tyan Tiger MPX board with a w83782d chip. Output from
> "sensors":
>=20
> w83782d-i2c-0-2d
> Adapter: SMBus AMD768 adapter at 80e0
>  +5 V:     +4.81 V  (min =3D  +4.76 V, max =3D  +5.24 V)
> 3 VSB:     +3.30 V  (min =3D  +2.85 V, max =3D  +3.15 V)       ALARM
> chs3 Fan: 2122 RPM  (min =3D 2657 RPM, div =3D 4)              ALARM
> VRM2 Temp:  -208=B0C  (high =3D  -176=B0C, hyst =3D  -181=B0C)   sensor =
=3D transistor=20
> CPU1 Temp: +78.5=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D transistor   ALARM
> CPU2 Temp: +77.5=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =
=3D transistor   ALARM
> alarms:
> beep_enable:
>           Sound alarm enabled
>=20
> # cat /sys/bus/i2c/devices/0-002d/temp*_input
> -209000
> 77500
> 77500
>=20
> Any ideas?

Please run the following commands as root (against both kernel versions) and
reply-to-all with the results:

	# modprobe i2c-dev
	# i2cdump -y 0 0x2d b 0 0x4e
	# i2cdump -y 0 0x48
	# i2cdump -y 0 0x49

Also, can you confirm that you're using the sensors.conf from here:
http://www.tyan.com/support_download_utility.aspx?model=3Ds.s2466

Finally, can you confirm that "sensors -s" is running (without error) some
time during system startup, w/ both kernel versions?

Thanks & regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
