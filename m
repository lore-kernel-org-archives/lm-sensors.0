From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Nov 2010 14:37:34 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <20101111153734.70ecdda9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 8 Nov 2010 19:13:54 +0200, Alexandros Diamantidis wrote:
> * Luca Tettamanti [2010-11-08 13:53]:
> > > atk0110-acpi-0
> > > CPU Fan Speed: =A0 =A0675000 RPM =A0(min =3D =A0600 RPM)
> >=20
> > There's something wrong with the reading of this fan. Can you send me
> > a copy of the DSDT table (/sys/firmware/acpi/tables/DSDT)?
>=20
> Oops, I hadn't noticed that!
>=20
> In fact, that fan speed is usually read correctly, but intermittently
> jumps to some absurd value. I don't think it's a problem of the driver,
> since I see this in the BIOS "system info" screen as well.

This is a common problem when using external fan speed control
solutions (potentiometers, fanbus and the like.) The degraded power
signal makes it harder for the tachometer to sample the speed signal.

I presume that some self-controlled fans could also suffer from the
same problem, depending on the exact implementation.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
