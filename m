From: "Gary E. Miller" <gem@rellim.com>
Date: Fri, 25 May 2012 18:10:56 +0000
Subject: [lm-sensors] Supermicro X8DTN config file
Message-Id: <20120525111056.3b0ec381.gem@rellim.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8278682719148103179=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8278682719148103179==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/sZI5IDXz=Y4x02lInsyNF8i"; protocol="application/pgp-signature"

--Sig_/sZI5IDXz=Y4x02lInsyNF8i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Yo lm-sesors!

See below for a working sensors3.conf file for the Supermicro X8DTN
motherboard.

How do I get it posted on the wiki for others to use?

RGDS
GARY
---------------------------------------------------------------------------
Gary E. Miller Rellim 109 NW Wilmington Ave., Suite E, Bend, OR 97701
	gem@rellim.com  Tel:+1(541)382-8588

# /etc/sensors.d/X8DTN
# settings for the supermicro X8DTN
# originally written by Gary E. Miller <gem@rellim.com>
# use at your own risk !
# Date: 25 May 2012

# Here's the info as supplied by Supermicro:

#
# Bus Type =3D ISAIO/SMBus
# One W83795AG
#=20
# Windbond W83795AG, Slave Address=3D0x2f (0x5E in 8-Bit format)
# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# Fan1 Fan Speed, Offset 0x2e		RPM =3D 84375/Data
# Fan2 Fan Speed, Offset 0x2f		RPM =3D 84375/Data
# Fan3 Fan Speed, Offset 0x30		RPM =3D 84375/Data
# Fan4 Fan Speed, Offset 0x31		RPM =3D 84375/Data
# Fan5 Fan Speed, Offset 0x32		RPM =3D 84375/Data
# Fan6 Fan Speed, Offset 0x33		RPM =3D 84375/Data
# Fan7 Fan Speed, Offset 0x34		RPM =3D 84375/Data
# Fan8 Fan Speed, Offset 0x35		RPM =3D 84375/Data
# CPU1 Voltage, Offset 0x10		Voltage =3D Data* 0.008
# CPU2 Voltage, Offset 0x11		Voltage =3D Data* 0.008
# +1.5V Voltage, Offset 0x12		Voltage =3D Data* 0.008
# +5V Voltage, Offset 0x13		Voltage =3D Data* 0.008 * (40/10)
# +12V Voltage, Offset 0x14		Voltage =3D Data* 0.008/ (10./66.2)
# +5VSB Voltage, Offset 0x15		Voltage =3D Data* 0.008 * (40/10)
# +3.3V Voltage, Offset 0x1c		Voltage =3D Data* 0.024
# +3.3VSB Voltage, Offset 0x1d		Voltage =3D Data* 0.024
# Battery Voltage, Offset 0x1e		Voltage =3D Data* 0.024
# CPU1 Temperature, Offset 0x27		Temperature =3D Data
# CPU2 Temperature, Offset 0x26		Temperature =3D Data
# System Temperature, Offset 0x1f		Temperature =3D Data
# Chassis Intrusion, Bank 0, Offset 0x46, BitMask 0x40	1 =3D Bad, 0 =3D Good
#		 (Clear Bit: Bank 0, Offset 0x4d, BitMask 0x80)
#=20
#=20
# Power Supply Failure, GP11(From W83627HF)		1 =3D Good, 0 =3D Bad
=20
chip "w83627hf-isa-0a00"
    # I'm not sure which is GP11, so I turned off everything.
    ignore in0
    ignore in1
    ignore in2
    ignore in3
    ignore in4
    ignore in5
    ignore in6
    ignore in7
    ignore in8
    ignore cpu0_vid
    ignore fan1
    ignore fan2
    ignore fan3
    ignore temp1
    ignore temp2
    ignore temp3
=20
bus "i2c-0" "SMBus I801 adapter at 0400"

chip "w83795adg-i2c-0-2f"

# Voltages ; note that in the table above, the .008 and .024 factors are
# already computed in the driver...

    label in0 "CPU1"
    label in1 "CPU2"
    label in2 "+1.5V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "5VSB"
    label in11 "Vtt"
    label in12 "+3.3V"
    label in13 "3VSB"
    label in14 "Vbat"

    compute in3 @*4, @/4
    compute in4 @*6.62, @/6.62
    compute in5 @*4, @/4
    compute in6 @*3, @/3

    label temp3 "unused"
    label temp4 "unused"
    label temp5 "mobo"
    label temp7 "CPU1"
    label temp8 "CPU2"

    ignore in6
    ignore in7
    ignore in11
    ignore temp3
    ignore temp4
    ignore fan4
    ignore fan5
    ignore fan6
    ignore fan7
    ignore fan8

    set in0_min  0.82
    set in0_max  1.35
    set in1_min  0.82
    set in1_max  1.35
    set in12_min  3.3 * 0.90
    set in12_max  3.3 * 1.10
    set in13_min  3.3 * 0.90
    set in13_max  3.3 * 1.10
    set in14_min  3.0 * 0.90
    set in14_max  3.3 * 1.10



--Sig_/sZI5IDXz=Y4x02lInsyNF8i
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk+/yzQACgkQBmnRqz71OvPbVwCgj7jwXJ1fNAHlLHsl8kynurxA
WacAn0kPf7Y1AG3gXlyYT4+OMux644Vq
=8tg1
-----END PGP SIGNATURE-----

--Sig_/sZI5IDXz=Y4x02lInsyNF8i--


--===============8278682719148103179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8278682719148103179==--
