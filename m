From: Olaf Mandel <olaf@mandel.name>
Date: Mon, 30 Aug 2010 17:32:57 +0000
Subject: Re: [lm-sensors] Config for MSI X58 Pro-E (MS-7522)
Message-Id: <4C7BEB49.1010100@mandel.name>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4178937809974036689=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4C6BFB8A.7060300@mandel.name>
In-Reply-To: <4C6BFB8A.7060300@mandel.name>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4178937809974036689==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4E6FA570201FC970569469E2"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E6FA570201FC970569469E2
Content-Type: multipart/mixed;
 boundary="------------030305050402010401070709"

This is a multi-part message in MIME format.
--------------030305050402010401070709
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 22.08.2010 16:13, schrieb Jean Delvare:
> On Sun, 22 Aug 2010 15:13:05 +0200, Olaf Mandel wrote:
-Snipp-
>=20
> The problem is that you compared the Vcore in BIOS, without CPU
> frequency scaling, with Vcore in sensors, with CPU frequency scaling
> enabled (as can be seen from the two outputs below.) This isn't fair!
>=20
Hi Jean,

I have to agree, the previous compute line was wrong.

> If you compare with Linux underload instead, you see Vcore (unscaled)
> at 1.12 V. This is definitely not 35% off compared to the BIOS's report=

> of 1.224 V. To be honest, I would have expected both values to match
> exactly. I get to suspect that your Linux system is configured to
> prevent the CPU to enter the highest frequency states, you may want to
> check this.
>=20
That was indeed the case: thermal_throttle was limiting the clock speed.
I checked the voltage by setting the clock speed manually and it gets at
least closer.

-Snipp-
>=20
> Your CPU cooling seems insufficient. A 56=C2=B0C difference between idl=
e and
> load is very, very much. I'd be worried.
>=20
It only gets hot if I run many instances of burnK7. If I just up the
clock speed, it doesn't get hot.

-Snipp-
> When you have come up with a "final" configuration file, please send it=

> over, and I'll put it on the wiki.
>=20

Ok, it's attached to the mail. It remained nearly unchanged, except for
the compute lines and the limits you suggested. The two non-trivial
compute lines are taken from comparison of values (BIOS<->sensors) and
then searching the nearest simple voltage divider that would work. The
values are pure guesses!

Thank you again for your help!

Best regards,
Olaf Mandel
--=20
Olaf Mandel   <olaf@mandel.name>   <http://www.olaf.mandel.name/>
PGP key:      1024D/33398848 2002-09-19
Fingerprint:  0E33 BEA6 1A71 9C5E 62BD  FC0E 99A7 D2C6 3339 8848

--------------030305050402010401070709
Content-Type: text/plain;
 name="sensors.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sensors.conf"

IyBjb25maWd1cmF0aW9uIGZvciB0aGUgRmludGVrIGY3MTg4MmZnIGFzIHVzZWQgb24gdGhl
IE1TSSBYNTggUHJvLUUgKE1TLTc1MjIpCmNoaXAgImY3MTg4MmZnLSoiCgojIFRlbXBlcmF0
dXJlCiAgICBsYWJlbCAgIHRlbXAxICJDUFUiCiAgICBsYWJlbCAgIHRlbXAyICJJT0giCiAg
ICBsYWJlbCAgIHRlbXAzICJTeXN0ZW0iCgojIEZhbnMKICAgIGxhYmVsICAgZmFuMSAgIkNQ
VSIKICAgIGxhYmVsICAgZmFuMiAgIlN5c3RlbSAxIiAjIFRoaXMgaXMgbm90IGNvbmZpcm1l
ZAogICAgbGFiZWwgICBmYW4zICAiU3lzdGVtIDIiCiAgICBpZ25vcmUgIGZhbjIKICAgIGln
bm9yZSAgZmFuNAoKIyBWb2x0YWdlCiAgICBsYWJlbCAgIGluMCAgICIzLjNWIgogICAgbGFi
ZWwgICBpbjEgICAiVmNvcmUiCiAgICBpZ25vcmUgIGluMgogICAgaWdub3JlICBpbjMKICAg
IGxhYmVsICAgaW40ICAgIjVWIgogICAgbGFiZWwgICBpbjUgICAiMTJWIgogICAgaWdub3Jl
ICBpbjYKICAgIGxhYmVsICAgaW43ICAgIjNWU0IiCiAgICBsYWJlbCAgIGluOCAgICJWYmF0
IgogICAgY29tcHV0ZSBpbjAgICAoQCAqIDIpLCAoQCAvIDIpICMgSGFyZHdpcmVkIGluIGNo
aXAsIGRvbid0IGNoYW5nZQogICAgY29tcHV0ZSBpbjEgICBALCBACiAgICBjb21wdXRlIGlu
NCAgIChAICogNS4yNSksIChAIC8gNS4yNSkgIyBFMjQ6ICgxMiArIDUxKSAvIDEyCiAgICBj
b21wdXRlIGluNSAgIChAICogMTEpLCAoQCAvIDExKSAgICAgIyBFNjogICggMSArIDEwKSAv
ICAxCiAgICBjb21wdXRlIGluNyAgIChAICogMiksIChAIC8gMikgIyBIYXJkd2lyZWQgaW4g
Y2hpcCwgZG9uJ3QgY2hhbmdlCiAgICBjb21wdXRlIGluOCAgIChAICogMiksIChAIC8gMikg
IyBIYXJkd2lyZWQgaW4gY2hpcCwgZG9uJ3QgY2hhbmdlCgojIFRocmVzaG9sZHMKICAgIHNl
dCBpbjFfbWF4ICAgICAgICAgICAxLjMKICAgIHNldCB0ZW1wMV9tYXggICAgICAgIDg1CiAg
ICBzZXQgdGVtcDFfbWF4X2h5c3QgICA4MgogICAgc2V0IHRlbXAxX2NyaXQgICAgICAxMDAK
ICAgIHNldCB0ZW1wMV9jcml0X2h5c3QgIDk3CiAgICBzZXQgdGVtcDJfbWF4ICAgICAgICA3
NQogICAgc2V0IHRlbXAyX21heF9oeXN0ICAgNzIKICAgIHNldCB0ZW1wMl9jcml0ICAgICAg
IDg1CiAgICBzZXQgdGVtcDJfY3JpdF9oeXN0ICA4MgogICAgc2V0IHRlbXAzX21heCAgICAg
ICAgNTUKICAgIHNldCB0ZW1wM19tYXhfaHlzdCAgIDUyCiAgICBzZXQgdGVtcDNfY3JpdCAg
ICAgICA2NQogICAgc2V0IHRlbXAzX2NyaXRfaHlzdCAgNjIK
--------------030305050402010401070709--

--------------enig4E6FA570201FC970569469E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkx7608ACgkQmafSxjM5iEic8ACfbINpaca7fmPKRH2Gypa7o3cy
R50AoK9Em+QqaCsEvVSqbN7kMmCGWbVd
=bmzH
-----END PGP SIGNATURE-----

--------------enig4E6FA570201FC970569469E2--


--===============4178937809974036689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4178937809974036689==--
