From: Chris Picton <chrisp@tangent.co.za>
Date: Mon, 19 Nov 2007 10:06:23 +0000
Subject: [lm-sensors] Sensors on an nforce2 motherboard giving incorrect
Message-Id: <1195466783.8463.19.camel@jabberwock>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3736113183993163556=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============3736113183993163556==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qJbuHp/PT1RXh2SO/eqi"


--=-qJbuHp/PT1RXh2SO/eqi
Content-Type: multipart/mixed; boundary="=-CYG2iPIhy+BOpWHkK/t4"


--=-CYG2iPIhy+BOpWHkK/t4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

I have an aopen XC cube EZ18 with an nforce2 based motherboard

I am trying to get lm-sensors working, but am not getting the correct
readings

I have attached outputs of lspci -v, lspci -n, sensors-detect, dmidecode

smartbatt and pca9540 don't seem to exist in my kernel sources
(linux-2.6.22-gentoo-r8)

w83627hf and max6650 do load without errors

when I run sensors, I get what I have pasted below

Note how no fan speeds are detected and temps are way too low (my
ambient is about 28 C)
In my bios, all speeds/temps seem to be picked up OK

Regards

Chris


---------------------------------
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +1.55 V  (min =3D  +0.00 V, max =3D  +4.08 V)             =20
VCore 2:   +1.58 V  (min =3D  +0.00 V, max =3D  +4.08 V)             =20
+3.3V:     +3.31 V  (min =3D  +2.82 V, max =3D  +3.79 V)             =20
+5V:       +4.97 V  (min =3D  +0.08 V, max =3D  +1.80 V)       ALARM =20
+12V:     +11.86 V  (min =3D  +0.79 V, max =3D  +8.33 V)       ALARM =20
-12V:     -11.87 V  (min =3D  -4.14 V, max =3D -13.59 V)       ALARM =20
-5V:       -5.05 V  (min =3D  +2.19 V, max =3D  -2.43 V)       ALARM =20
V5SB:      +5.46 V  (min =3D  +0.48 V, max =3D  +0.38 V)       ALARM =20
VBat:      +3.18 V  (min =3D  +0.13 V, max =3D  +3.65 V)             =20
fan1:        0 RPM  (min =3D 42187 RPM, div =3D 2)              ALARM =20
fan2:        0 RPM  (min =3D 4856 RPM, div =3D 2)              ALARM =20
fan3:        0 RPM  (min =3D 9926 RPM, div =3D 2)              ALARM =20
temp1:       +17 C  (high =3D   +99 C, hyst =3D   +11 C)   sensor =3D
thermistor          =20
temp2:     +18.5 C  (high =3D   +70 C, hyst =3D   +65 C)   sensor =3D
thermistor          =20
temp3:     +19.0 C  (high =3D   +80 C, hyst =3D   +80 C)   sensor =3D
thermistor          =20
vid:      +0.000 V  (VRM Version 9.0)
alarms:  =20
beep_enable:
          Sound alarm disabled

max6650-i2c-5-1b
Adapter: NVIDIA i2c adapter=20
fan1:     configured 59531 RPM, actual    0 RPM.
fan2:        0 RPM
fan3:        0 RPM
fan4:        0 RPM

max6650-i2c-5-1f
Adapter: NVIDIA i2c adapter=20
fan1:     configured 59531 RPM, actual    0 RPM.
fan2:        0 RPM
fan3:        0 RPM
fan4:        0 RPM

max6650-i2c-5-48
Adapter: NVIDIA i2c adapter=20
fan1:     configured 59531 RPM, actual    0 RPM.
fan2:        0 RPM
fan3:        0 RPM
fan4:        0 RPM

max6650-i2c-5-4b
Adapter: NVIDIA i2c adapter=20
fan1:     configured 59531 RPM, actual    0 RPM.
fan2:        0 RPM
fan3:        0 RPM
fan4:        0 RPM
---------------------------------------

---------------------+-----------------------------------------------------=
--
        Chris Picton | PGP Key ID: 9D28A988 (wwwkeys.pgp.net)
  Technical Director | PGP Key Fingerprint:
     Tangent Systems | 2B46 29EA D530 79EC D9EA 3ED0 229D 6DD6 9D28 A988
        011 447 8096 |=20
chrisp@tangent.co.za | http://www.tangent.co.za/keys/chrisp.asc
---------------------+-----------------------------------------------------=
--

--=-CYG2iPIhy+BOpWHkK/t4
Content-Disposition: attachment; filename=dmidecode.txt.bz2
Content-Type: application/x-bzip; name=dmidecode.txt.bz2
Content-Transfer-Encoding: base64

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
1B6Rsf8XckU4UJA49D73


--=-CYG2iPIhy+BOpWHkK/t4
Content-Disposition: attachment; filename=lspcin.txt.bz2
Content-Type: application/x-bzip; name=lspcin.txt.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWe0vWtsAAG3ZgAAQQGF/8D8AEQAwAOYBk1J6T0kyZ6EBQaNGgyA0ERQplHppogaU
ZgCM/+Jtd857l77RWFgaIGRGMWcF6N2QR6QRggjVwYZjVNRMyHmkXGyf9xNtaqqTF5fwDlehDjb1
27p4/RDY865+DRpTVl3ZQ7FqYr84CCV2L1FHKZyodw/CmnSpB1ANGhKlrU3xgMLjFWxA4lN/vzjP
MHjxLu0zgkHqDspCARkMySx25UMWTCWAlsy+lD6KntE1faJUT/F3JFOFCQ7S9a2w


--=-CYG2iPIhy+BOpWHkK/t4
Content-Disposition: attachment; filename=lspciv.txt.bz2
Content-Type: application/x-bzip; name=lspciv.txt.bz2
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWY5XXNgAA1rfgHwQQGf/8r/v/8o/79/wYAbc+6MqWwMhQAAAA5gCMExAMAmCaMho
YBMEYmGijU0ZHqfqmjRoGgAAAAAAAOYAjBMQDAJgmjIaGATBGJhJqSERHonqBk/Saj0nqDR6jQya
NDINAA5gCMExAMAmCaMhoYBMEYmCpJATTQKbRT0yMjSJ5T9JqehoTCMjGiZMxOeMDLJCDz9MHsyZ
UUueZZCvcNfj4kzqze36RtpLsFMiO0Ylqxq6rddykC8vSgzffuxH7/rhXLPMw7ecQGckRg1p1VLV
VV11ubvjnQBRh2Y9KehPxLzb0ZgyQb/pEKJNgNANagojE0ycHkmFMM8F+S6WuVc9ieqJjym9eHrx
9n1fPg3PS5e6cYqbHhIXtd3Tay2FaXr7uMi1vtD9G1k83MmUbDN564+uy8nblexz7tndp+y7HNr8
5L5fut+t6Wx3TJIFrMOEPHfayqsg8JA7Qa1V+FVIOgqbJwajVuSRw1eBMIXsFXQb5KgH5BgeiD5q
km+SUbHCO4maGkhhEwz6/xi+MBJcE1Du7CQ2IxiqQO9pUmap321UJ4by+yvr0cEMPTE9HdMlddT+
oLSSmDRxDHXJVt/3ksHunUPi64lIXuHo0+nb7Ptc+ezK+sbqWa4Mk4s4t429PHUlVeEyXYRJhIgR
ZDCMOGmsVCJkiJan21yGI8mKFgLU6pwKZaOkCAQIEuXLpbQ33Jt20nBdmhrdhV+5nyO9czL4ytab
amri+BLlz6/0yXNb8JHGtsstyib6K3ovbFBgtKbGS6rVf8cJllLOGds1PuC23RJhLbLVjt08pNpT
Hp1p8YnlrcnTOolzWbdmzJmul2bJhMoi6Q4dNVrbyZz8ydi/frwpTdZPQ4cKpjwwmqT/W0ntT3B8
rbZVyDql8pVfVT6Yvvibe4wmcQvMFWAjJNfUeXsQ6oIBTLESes6T28c+wXF0gXnEqAGwZ9eYUsad
oAwTKI3yHD0k8W8xz0+yXG+Q882xc8VRLiiP2J6XZU+arL2zWOpseuQwytVib6hrJKN4Vc/7FTs0
DsfRTkym8Lv3uJtU7abJFJ2SKU5paMEPY8FyHmqT8q4155CjSaKhDMrCIgCbcLb2PnOBLY0Fa8C+
4tTicsvVX22wsXS6o7FrMeDo6XbT1tPLJHNzoP4kPzI9kfZNXlJ5Iitr2v/R1k07nhEbH+ydOcpr
BndJOAni3N8GusRgu98tNPhIf5DptCZE5MZKQ42klNqGct2MmaZkW5WdBGLZUpNGkGBKnbeM2MXz
W+VU2KW0WkGtiTE8dG2Pli82O5gfcsdCpgron5Uh4bpehklV0PxE8drF+7udlPfeqzWPMMkjD75/
DGI1Q3E75IzqkugomebZI/kmAWhzeonheWdMk7ZD3urvZEaxGsiWmI6/V34DGWgx7SKmVS3Vjs7v
OLoemBuSOSTOa4SRdxT4VfC0hdIeAw1kMJeXOidnK6LJL5VIV/L+W2MI5aBq65C8zE3sU5LRyigq
NIjdJOLu1RNudIdMhaQ5jRDoXzZJKKkXSIomEh2JQLeyiG4mWTxQzgtMpet7pMonxTOZRM2OZFLq
qm4mzyqRgoi15DyRKtPbIpKl7a74jmRsfBjEXj0ySfcon0E1TjIf1f+BuiN3aqO1FKVKp/gZuckc
6qkT+60RYlEXJKdvUqng4vIhlsiKl38OqS2DYwl0uGRGLCIwklDOKjRSJRpjFSTxTGQqSWmMXNx6
ojjySdNe8SzHXWCuaFg2OSGe28y7W210i0FQrSJgHFkwXMSLMUKgoMZ8mpPwYZSHgWiO9kRojpfI
6o1epD5X1zR0e43mbovklToiMemSWSvki0RzQ5uqSeSIU0d7khUhuE/+LuSKcKEhHK65sA==


--=-CYG2iPIhy+BOpWHkK/t4
Content-Disposition: attachment; filename=sensors-detect.txt.bz2
Content-Type: application/x-bzip; name=sensors-detect.txt.bz2
Content-Transfer-Encoding: base64

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


--=-CYG2iPIhy+BOpWHkK/t4--

--=-qJbuHp/PT1RXh2SO/eqi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHQWAfIp1t1p0oqYgRAqrxAJ9gH0djkL65XFBUvwLznwChCvhrCQCfQRRv
t/Rc0HH1eFZbj8qGqzrBIN0=
=XWpT
-----END PGP SIGNATURE-----

--=-qJbuHp/PT1RXh2SO/eqi--



--===============3736113183993163556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3736113183993163556==--

