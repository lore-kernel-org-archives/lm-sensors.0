From: "Jordan Crouse" <jordan.crouse@amd.com>
Date: Mon, 18 Feb 2008 17:00:44 +0000
Subject: Re: [lm-sensors] adt7475 support (Asus M2N-SLI Deluxe)
Message-Id: <20080218170044.GA28982@cosmic.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0801211406570.32720@birdbird.example.com>
In-Reply-To: <Pine.LNX.4.64.0801211406570.32720@birdbird.example.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 13/02/08 17:53 +0100, Artur Szymiec wrote:
> Hello,
>=20
> I have a M2N-SLI Deluxe motherboard and
> i'm testing the Jordan Crouse patch
> (http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022338.htm=
l).
> Results from running sensors:
>=20
> 1st result:
> ADT7475-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 1c40
> vccp:        +0.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)   ALARM
> vcc:         +3.27 V  (min =3D  +0.00 V, max =3D  +4.28 V)
> Chasis 2:   2304 RPM  (min =3D  900 RPM)
> fan2:          0 RPM  (min =3D    0 RPM)
> fan3:          0 RPM  (min =3D    0 RPM)
> fan4:          0 RPM  (min =3D    0 RPM)
> remote1:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALARM
> local:       +42.5=B0C  (low  =3D +10.0=B0C, high =3D +45.0=B0C)
> remote2:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALARM
>=20
> 2nd result:
> ADT7475-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 1c40
> vccp:        +0.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)   ALARM
> vcc:         +3.27 V  (min =3D  +0.00 V, max =3D  +4.28 V)
> Chasis 2:   105882 RPM  (min =3D  900 RPM)
> fan2:          0 RPM  (min =3D    0 RPM)
> fan3:          0 RPM  (min =3D    0 RPM)
> fan4:          0 RPM  (min =3D    0 RPM)
> remote1:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALARM
> local:       +42.5=B0C  (low  =3D +10.0=B0C, high =3D +45.0=B0C)
> remote2:       FAULT  (low  =3D -63.0=B0C, high =3D +191.0=B0C)  ALARM
>=20
> Comment:
> The results 1 and 2 are from running the sensors command one by one
> with 3 sec delay between them.
> So obviously reading from fan1 (label Chassis 2) are not correct.
> Tested with kernel 2.6.24.

Thats unfortunate.  Is the problem easily reproducible?  Does the
bogus fan value remain forever or does it go back to a sane value
on the next read?

Jordan

--=20
Jordan Crouse
Systems Software Development Engineer=20
Advanced Micro Devices, Inc.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
