From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 24 Jan 2011 08:19:16 +0000
Subject: Re: [lm-sensors] insane readings on Asus A7M266 motherboard
Message-Id: <20110124091916.42575be3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <761574.42437.qm@web36601.mail.mud.yahoo.com>
In-Reply-To: <761574.42437.qm@web36601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

On Sun, 23 Jan 2011 14:27:26 -0800 (PST), Audio Phile wrote:
> I had to reinstall Linux after a HDD crash.  Before the crash, sensors wo=
uld work just fine with this board.  I am now unable to get it to work to c=
orrectly read the temp sensors.  If I look at them in the BIOS, the CPU is =
about 50C and the MB is about 35C.  When I view them in sensors, I get:
>=20
> # sensors
> via686a-isa-f000
> Adapter: ISA adapter
> Vcore:       +3.10 V  (min =3D  +3.10 V, max =3D  +3.10 V)  =20
> in1:         +3.10 V  (min =3D  +3.10 V, max =3D  +3.10 V)  =20
> +3.3V:       +3.12 V  (min =3D  +2.98 V, max =3D  +3.63 V)  =20
> +5V:         +6.44 V  (min =3D  +4.51 V, max =3D  +5.50 V)  =20
> +12V:       +15.60 V  (min =3D +10.81 V, max =3D +13.20 V)  =20
> fan1:       3026 RPM  (min =3D 2689 RPM, div =3D 2)
> fan2:          0 RPM  (min =3D    0 RPM, div =3D 2)
> temp1:      +146.2=B0C  (high =3D +146.2=B0C, hyst =3D +54.4=B0C) =20
> temp2:      +146.2=B0C  (high =3D +146.2=B0C, hyst =3D +54.4=B0C) =20
> temp3:      +135.2=B0C  (high =3D +146.2=B0C, hyst =3D +146.2=B0C) =20
>=20
> Hardware: Asus A7M266 (old, I know)

There's nothing wrong with running old hardware :)

> Sensors: sensors version 3.2.0 with libsensors version 3.2.0
> Kernel: 2.6.32 or 2.6.37
>=20
> Note that sensors-detect finds the "via686a" module but loading it does n=
othing without forcing an address as per the dmesg:
> via686a 0000:00:04.4: Sensors disabled, enable with force_addr=3D0xe300
>=20
> So I do it via: modprobe via686a force_addr=3D0xe300

This alone is usually a good hint that the VIA686A/B integrated sensors
aren't used on the board.

> Again, the temps are reasonable in the BIOS so I believe that the sensors=
 are fine.  Suggestions are welcomed.

The A7M266, as most Asus board at the time, is using an Asus-specific
ASIC for hardware monitoring, rather than the sensors integrated in the
south bridge. In your case, that would be an AS99127F, so you should
load the w83781d driver rather than the via686a driver. sensors-detect
should have told you exactly this, BTW. If it did not, please send the
full output of sensors-detect for analysis.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
