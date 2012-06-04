From: "Gary E. Miller" <gem@rellim.com>
Date: Mon, 04 Jun 2012 22:05:29 +0000
Subject: Re: [lm-sensors] Supermicro X7DB8 sensors3.conf
Message-Id: <20120604150529.6f4e0e19.gem@rellim.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6243071376110609742=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20120530143325.45feb5a2.gem@rellim.com>
In-Reply-To: <20120530143325.45feb5a2.gem@rellim.com>
To: lm-sensors@vger.kernel.org

--===============6243071376110609742==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/K3qp4lVydoK5T9p49MsnHWH"; protocol="application/pgp-signature"

--Sig_/K3qp4lVydoK5T9p49MsnHWH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Yo Jean!

On Mon, 4 Jun 2012 09:51:25 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> On Wed, 30 May 2012 14:33:25 -0700, Gary E. Miller wrote:

> > See below for a sensors3.conf file for the Supermicro X7DB8
> > motherboard.
> >=20
> > Please post on the wiki.
>=20
> Well we already have a configuration file for the X7DBE, which was
> supposedly compatible with that board... But maybe not.

If you compare the X7DBE file to mine you will see some of the
conversions are incorrect for the X7DB8.  Can't say if they are
correct for the X7DBE.

Notice I have also attached the info directly from the horses mouth (
Supermicro support) so you can double check my work.

RGDS
GARY
---------------------------------------------------------------------------
Gary E. Miller Rellim 109 NW Wilmington Ave., Suite E, Bend, OR 97701
	gem@rellim.com  Tel:+1(541)382-8588

>=20
> > -----------------------------------------------------------------------=
----
> > Gary E. Miller Rellim 109 NW Wilmington Ave., Suite E, Bend, OR
> > 97701 gem@rellim.com  Tel:+1(541)382-8588
> >=20
> > # /etc/sensors.d/X7DB8
> > # settings for the supermicro X7DB8
> > # originally written by Gary E. Miller <gem@rellim.com>
> > # use at your own risk !
> > # Date: 30 May 2012
> >=20
> > # Here's the info as supplied by Supermicro:
> >=20
> > #
> >=20
> > # Bus Type =3D SMBus
> > # One W83793G
> > #=20
> > # Windbond W83793G, Slave Address=3D0x2f (0x5E in 8-Bit format)
> > # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > # Fan1 Fan Speed, Offset 0x23, 0x24			RPM =3D
> > 1350000/Data # Fan2 Fan Speed, Offset 0x25,
> > 0x26			RPM =3D 1350000/Data # Fan3 Fan Speed,
> > Offset 0x27, 0x28			RPM =3D 1350000/Data # Fan4
> > Fan Speed, Offset 0x29, 0x2a			RPM =3D
> > 1350000/Data # Fan5 Fan Speed, Offset 0x2b,
> > 0x2c			RPM =3D 1350000/Data # Fan6 Fan Speed,
> > Offset 0x2d, 0x2e			RPM =3D 1350000/Data #
> > Fan7/CPU1 Fan Speed, Offset 0x2f, 0x30		RPM =3D
> > 1350000/Data # Fan8/CPU2 Fan Speed, Offset 0x31,
> > 0x32		RPM =3D 1350000/Data # CPU1 Core Voltage, Offset
> > 0x10			Voltage =3D Data* 0.008 # CPU2 Core
> > Voltage, Offset 0x11			Voltage =3D Data* 0.008 #
> > -12V Voltage, Offset 0x14				Voltage =3D
> > ((Data*0.016)- (2.048*(232./260.)))/(1-(232./260.)) # +1.5V
> > Voltage, Offset 0x15				Voltage =3D Data*
> > 0.016 # +3.3V Voltage, Offset 0x16
> > Voltage =3D Data* 0.016 # +12V Voltage, Offset
> > 0x17				Voltage =3D Data* 0.008/
> > (10./120.) # +5V Voltage, Offset
> > 0x18				Voltage =3D Data* 0.024 # 5Vsb
> > Voltage, Offset 0x19				Voltage =3D Data*
> > 0.024 # Battery Voltage, Offset 0x1a
> > Voltage =3D Data* 0.016 # CPU1 CoreA (PECI Agent1) Temperature,
> > Offset 0x1c	Temperature =3D Data # CPU1 CoreB (PECI Agent2)
> > Temperature, Offset 0x1d	Temperature =3D Data # CPU2 CoreA
> > (PECI Agent3) Temperature, Offset 0x1e	Temperature =3D Data #
> > CPU2 CoreB (PECI Agent4) Temperature, Offset 0x1f
> > Temperature =3D Data # System Temperature, Offset
> > 0x20			Temperature =3D Data # Chassis Intrusion,
> > Offset 0x44, BitMask 0x40		1 =3D Bad, 0 =3D Good # # #
> > Windbond W83627HF #
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D #
> > Power Supply Failure, GP11(From W83627HF)		1 =3D Good,
> > 0 =3D Bad #
> >=20
> > chip "w83627hf-isa-0290"
> >     # no driver access to GP11, so I turned off everything.
> >     ignore in0
> >     ignore in1
> >     ignore in2
> >     ignore in3
> >     ignore in4
> >     ignore in5
> >     ignore in6
> >     ignore in7
> >     ignore in8
> >     ignore cpu0_vid
> >     ignore fan1
> >     ignore fan2
> >     ignore fan3
> >     ignore temp1
> >     ignore temp2
> >     ignore temp3
>=20
> Again, best is to just not load the driver in the first place.
>=20
> >=20
> >=20
> >=20
> > bus "i2c-0" "SMBus I801 adapter at 1100"
> >=20
> > chip "w83793-i2c-0-2f"
> >=20
> > 	label fan7	fanCPU1
> > 	label fan8	fanCPU2
> >=20
> > # Voltages ; note that in the table above, the .008, .016, and .024
> > factors are # already computed in the driver...
> > 	label in0 "CPU1"
> > 	label in1 "CPU2"
> > 	ignore in2
> > 	label in3 "-12V"
> > 	label in4 "1.5V"
> > 	label in5 "3.3V"
> > 	label in6 "12V"
> > 	label in7 "5V"
> > 	label in8 "5Vsb"
> > 	label in9 "Vbat"
> >=20
> > 	label temp1 "CPU1 CoreA"
> > 	label temp2 "CPU1 CoreB"
> > 	label temp3 "CPU2 CoreA"
> > 	label temp4 "CPU2 CoreB"
> > 	label temp5 "mobo"
> >=20
> > 	compute in3  (@ - (2.048*(232/260)))/(1-(232/260)),
> > (@*(1-(232/260)))+(2.048*(232/260)) compute in6  @ * 12 , @ / 12
> >=20
> >=20
> > 	# CPUs
> > 	set in0_min  0.82
> > 	set in0_max  1.35
> > 	set in1_min  0.82
> > 	set in1_max  1.35
> >=20
> > 	# -12V, 10%
> > 	set in3_max  -12.0 * 0.90
> > 	set in3_min  -12.0 * 1.10
> > 	# 3.3V, 5%
> > 	set in5_min  3.3 * 0.95
> > 	set in5_max  3.3 * 1.05
> > 	# 12V, 10%
> > 	set in6_min  12.0 * 0.90
> > 	set in6_max  12.0 * 1.10
> > 	# 5V, 10%
> > 	set in7_min  5.0 * 0.90
> > 	set in7_max  5.0 * 1.10
> > 	# 5Vsb, 10%
> > 	set in8_min  5.0 * 0.90
> > 	set in8_max  5.0 * 1.10
> > 	# Vbat, 10%
> > 	set in9_min  3.0 * 0.90
> > 	set in9_max  3.0 * 1.10
>=20
> You are too tolerant, ATX specifications says +/- 5% for +5V, +12V and
> 5VSB. I admit it's not rare to see 5VSB diverge by more than 5%, but
> +5V and +12V definitely shouldn't.
>=20
> Cleaned up configuration file is at:
> http://www.lm-sensors.org/wiki/Configurations/SuperMicro/X7DB8
>=20
> Thanks for your contribution!
>=20




--Sig_/K3qp4lVydoK5T9p49MsnHWH
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk/NMTAACgkQBmnRqz71OvNR8ACfd7BcoNPuMnEFd0mfF+N9bWve
1a0AoKA5peXYeCUgmgDh8MF7/1xA4C2Q
=KVIx
-----END PGP SIGNATURE-----

--Sig_/K3qp4lVydoK5T9p49MsnHWH--


--===============6243071376110609742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6243071376110609742==--
