From: Olaf Mandel <olaf@mandel.name>
Date: Sun, 22 Aug 2010 13:13:05 +0000
Subject: Re: [lm-sensors] Config for MSI X58 Pro-E (MS-7522)
Message-Id: <4C712261.9090708@mandel.name>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3696359062408025230=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4C6BFB8A.7060300@mandel.name>
In-Reply-To: <4C6BFB8A.7060300@mandel.name>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3696359062408025230==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig95E35F8CEBDA39CBDB164B2D"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95E35F8CEBDA39CBDB164B2D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 22.08.2010 14:38, schrieb Jean Delvare:
-Snipp-
> On Wed, 18 Aug 2010 17:26:02 +0200, Olaf Mandel wrote:
-Snipp-
>> * The System1 fan could be on either fan2 or fan3
>=20
> This should be easy enough to verify. You can temporarily unplug any
> system fan (or slow it down by pressing your finger on the middle part =
-
> don't get hurt), and see which reported speed drops.
>=20
Hi Jean,

unfortunately, I cannot do that: the motherboard is build into a
root-server I rented and is located in a remote location I have no
physical access to. I can ask for access to its monitor and keyboard via
a remote KVM solution in order to access the BIOS information, but that
is about the end of it. The server operator charges per 15min of "remote
hands", and I am to stingy to ask them to swap the fan connection.

>> * There are several 3.3V inputs, but which one corresponds to the one
>> shown in the BIOS?
>=20
> Most certainly in0. in7 is 3VSB (Stand-By 3.3V) and in8 is Vbat
> (battery). It's quite rare that BIOS reports these.
>=20
Thanks for the info. I have updated my configuration file accordingly.

>> * The calibration values for in1, in4 and in5 are only approximations
>> * No min, max or critical values are given here.
>=20
> Easy enough to add once you are certain your configuration is OK.
>=20
If you mean the thresholds: how does one decide on which values are
max/min, or critical?

-Snipp-
>>     ignore  fan4
>=20
> No 4th fan header, or just unused on your system? You should only
> ignore a fan when the header isn't there.
>=20
I checked the manual: there is a "System 3" Fan, but it does not seem to
have a Sensor connector (the pin is labeled "No Use" in the manual and
the BIOS does not report it).

-Snipp-
>>     compute in1   (@ * 1.35), (@ / 1.35)
>=20
> This would be quite surprising. On recent CPUs, Vcore is always lower
> than the ADC's resolution, so it shouldn't need any scaling. How did
> you come with this value?
>=20

I ran several comparisons between readouts from the BIOS and running
sensors with a dummy configuration. Then I tweaked the compute values to
match as well as possible the BIOS values. I read in the BIOS (some
values were quite noisy):

CPU Vcore           1.224V
3.3V                3.376V
5V                  4.961V
12V                12.144V

Vcore was very stable, so I tuned compute1 to match it. For compute5, I
did the same (even though the values varied slightly). I cannot
remember, whether I did the same to compute4 or stayed with the default.

-Snipp-
> When sending such configuration files, it is a good practice to also
> include the output of "sensors -c /dev/null", so that we can review
> your choices and possibly help you improve your configuration file.
>=20

Sure (the long "sensor =3D ..." lines get folded by my MUA):

unloaded machine:
f71882fg-isa-0a00
Adapter: ISA adapter
in0:         +1.70 V
in1:         +0.92 V  (max =3D  +2.04 V)
in2:         +0.02 V
in3:         +0.00 V
in4:         +0.94 V
in5:         +1.11 V
in6:         +0.21 V
in7:         +1.68 V
in8:         +1.63 V
fan1:       2407 RPM
fan2:          0 RPM  ALARM
fan3:       1758 RPM
fan4:          0 RPM  ALARM
temp1:       +22.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
                      (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sensor =
=3D Intel
PECI
temp2:       +59.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
                      (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sensor =
=3D
transistor
temp3:       +44.0=B0C  (high =3D +255.0=B0C, hyst =3D +253.0=B0C)
                      (crit =3D +255.0=B0C, hyst =3D +253.0=B0C)  sensor =
=3D
transistor

machine loaded by 8 instances of burnK7:
f71882fg-isa-0a00
Adapter: ISA adapter
in0:         +1.68 V
in1:         +1.12 V  (max =3D  +2.04 V)
in2:         +0.48 V
in3:         +0.29 V
in4:         +0.94 V
in5:         +1.10 V
in6:         +0.52 V
in7:         +1.68 V
in8:         +1.63 V
fan1:       2407 RPM
fan2:          0 RPM  ALARM
fan3:       1706 RPM
fan4:          0 RPM  ALARM
temp1:       +78.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
                      (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sensor =
=3D Intel
PECI
temp2:       +65.0=B0C  (high =3D +255.0=B0C, hyst =3D +251.0=B0C)
                      (crit =3D +255.0=B0C, hyst =3D +251.0=B0C)  sensor =
=3D
transistor
temp3:       +43.0=B0C  (high =3D +255.0=B0C, hyst =3D +253.0=B0C)
                      (crit =3D +255.0=B0C, hyst =3D +253.0=B0C)  sensor =
=3D
transistor


Any further suggestions on how to tweak the warning levels for all the
settings?

Best regards,
Olaf Mandel
--=20
Olaf Mandel   <olaf@mandel.name>   <http://www.olaf.mandel.name/>
PGP key:      1024D/33398848 2002-09-19
Fingerprint:  0E33 BEA6 1A71 9C5E 62BD  FC0E 99A7 D2C6 3339 8848


--------------enig95E35F8CEBDA39CBDB164B2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkxxImgACgkQmafSxjM5iEg6bwCgrh2bGED29PI7M06p3WhgMpkK
GN0An1yxFRQ/wKKhOzTl7TFUGxwKCbaq
=9Qe7
-----END PGP SIGNATURE-----

--------------enig95E35F8CEBDA39CBDB164B2D--


--===============3696359062408025230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3696359062408025230==--
