From: Roman Mamedov <roman@rm.pp.ru>
Date: Mon, 01 Mar 2010 13:49:36 +0000
Subject: Re: [lm-sensors] ASUS CUSL2: sensors work with 2.6.30,
Message-Id: <20100301184936.32cf4ce4@natsu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1331292175693768442=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100301033233.66b4f25f@natsu>
In-Reply-To: <20100301033233.66b4f25f@natsu>
To: lm-sensors@vger.kernel.org

--===============1331292175693768442==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/jSZtC5/_GDXe+DUuzy031.D"; protocol="application/pgp-signature"

--Sig_/jSZtC5/_GDXe+DUuzy031.D
Content-Type: multipart/mixed; boundary="MP_/loOL59Zag.XUa9S4othQHlZ"

--MP_/loOL59Zag.XUa9S4othQHlZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 1 Mar 2010 13:55:48 +0100
Luca Tettamanti <kronos.it@gmail.com> wrote:

> On Mon, Mar 1, 2010 at 1:48 PM, Roman Mamedov <roman@rm.pp.ru> wrote:
> >> * The kernel log messages when cycling the i2c-i801 driver ("rmmod
> >> =C2=A0 i2c-i801 && modprobe i2c-i801" as root)
> >
> > There are no messages in dmesg or syslog when removing and reloading th=
is
> > driver in 2.6.30, but in 2.6.33 there are errors:
> >
> > [ =C2=A0173.468108] ACPI: I/O resource 0000:00:1f.3 [0xe800-0xe80f] con=
flicts
> > with ACPI region SM00 [0xe800-0xe806]
> > [ =C2=A0173.468125] ACPI: If an ACPI driver is available for this devic=
e, you
> > should use it instead of the native driver
>=20
> From ioports:
> e800-e80f : 0000:00:1f.3
>   e800-e80f : i801_smbus
>=20
> So the ports used by i801_smbus are actually claimed by ACPI; 2.6.30
> did not enforce the reservation, .33 does.
> You might be able to use asus_atk0110 ACPI driver on your board;

If I understood you correctly:

# modprobe asus_atk0110
# lsmod | grep asus
asus_atk0110            9890  0=20
# sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.

...this didn't seem to work.

> if it
> does not work please send me a copy of /sys/firmware/acpi/tables/DSDT,

Attached.

--=20
With respect,
Roman

--MP_/loOL59Zag.XUa9S4othQHlZ
Content-Type: application/x-gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=DSDT.gz

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

--MP_/loOL59Zag.XUa9S4othQHlZ--

--Sig_/jSZtC5/_GDXe+DUuzy031.D
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuLxfAACgkQTLKSvz+PZwgUHwCfWVKGrisFrnT06AMfH2ieLANA
1YQAnj3RxpzSO33otifiwnAeD+WyePOy
=4a/F
-----END PGP SIGNATURE-----

--Sig_/jSZtC5/_GDXe+DUuzy031.D--


--===============1331292175693768442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1331292175693768442==--
