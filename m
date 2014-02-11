From: =?ISO-8859-1?Q?J=FCrgen_Fuchsberger?= <juergen.fuchsberger@uni-graz.at>
Date: Tue, 11 Feb 2014 09:54:55 +0000
Subject: Re: [lm-sensors] Kernel errors for dme1737
Message-Id: <52F9F36F.40402@uni-graz.at>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0523326258402050076=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
In-Reply-To: <CADLDEKtzZeoOyyUGe7Rug8n-c0oZ_n8Cqd=HFpPZdZWgYmJARg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0523326258402050076==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ownGU6KuLMNHVoppLGQjFl8dMafxKgDOp"

--ownGU6KuLMNHVoppLGQjFl8dMafxKgDOp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 02/11/2014 08:32 AM, Juerg Haefliger wrote:
> Hi Juergen,
>=20
> You're likely to get better help by contacting the LM sensors mailing
> list (cc'ed). I've been out of it for a bit.

Thanks!
>=20
>=20
>> Dear Juerg,
>>
>> I keep getting Errors of this kind:
>>
>> Feb 10 09:51:09 wegc203094 kernel: [  156.372033] dme1737 1-002c: Read=

>> from register 0x6d failed! Please report to the driver maintainer.
>> Feb 10 09:53:09 wegc203094 kernel: [  276.472043] dme1737 1-002c: Read=

>> from register 0x69 failed! Please report to the driver maintainer.
>=20
> Can you post all messages from the driver from the time it was loaded?

Feb 10 09:48:47 wegc203094 kernel: [    8.368070] i2c i2c-1: Found a
DME1737 chip at 0x2c (rev 0x8a).
Feb 10 09:48:47 wegc203094 kernel: [    8.384103] dme1737 1-002c:
Optional features: pwm3=3Dno, pwm5=3Dno, pwm6=3Dno, fan3=3Dno, fan4=3Dno,=
 fan5=3Dno,
fan6=3Dno.
Feb 10 09:4


> What's the model of the machine you're using?
Hmm, unfortunately I don't know. Is there a way to find out without
opening the server? (I mean by sw-tools?)

> What do you get when running the sensors-detect script?

~ % sensors



dme1737-i2c-1-2c
Adapter: SMBus nForce2 adapter at 2e00
5VSB:         +1.41 V  (min =3D  +4.50 V, max =3D  +5.50 V)  ALARM
Vcore:        +0.00 V  (min =3D  +0.00 V, max =3D  +2.99 V)  ALARM
+3.3V:        +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
+5V:          +1.52 V  (min =3D  +4.50 V, max =3D  +5.50 V)  ALARM
+12V:        +12.24 V  (min =3D +10.81 V, max =3D +13.19 V)
3VSB:         +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
Vbat:         +3.01 V  (min =3D  +2.70 V, max =3D  +3.30 V)
fan1:           0 RPM  (min =3D    0 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
temp1:          FAULT  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  ALARM
SIO Temp:     +40.3=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
temp3:          FAULT  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  ALARM
cpu0_vid:    +0.763 V

emc6d103-i2c-1-2d
Adapter: SMBus nForce2 adapter at 2e00
in0:          +0.13 V  (min =3D  +0.00 V, max =3D  +3.32 V)
Vcore:        +0.17 V  (min =3D  +0.00 V, max =3D  +2.99 V)
+3.3V:        +3.29 V  (min =3D  +2.97 V, max =3D  +3.63 V)
+5V:          +5.09 V  (min =3D  +4.50 V, max =3D  +5.50 V)
+12V:        +12.15 V  (min =3D  +0.00 V, max =3D +15.94 V)
fan1:           0 RPM  (min =3D    0 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:        13267 RPM  (min =3D    0 RPM)
fan4:           0 RPM  (min =3D    0 RPM)
temp1:        +39.1=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
M/B Temp:     +35.0=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
temp3:        +34.8=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
cpu0_vid:    +1.550 V

emc6d103-i2c-1-2e
Adapter: SMBus nForce2 adapter at 2e00
in0:          +1.82 V  (min =3D  +0.00 V, max =3D  +3.32 V)
Vcore:        +1.06 V  (min =3D  +0.00 V, max =3D  +2.99 V)
+3.3V:        +3.29 V  (min =3D  +2.97 V, max =3D  +3.63 V)
+5V:          +5.09 V  (min =3D  +4.50 V, max =3D  +6.64 V)
+12V:        +12.11 V  (min =3D  +0.00 V, max =3D +15.94 V)
fan1:           0 RPM  (min =3D    0 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
fan4:           0 RPM  (min =3D    0 RPM)
temp1:        +40.4=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
M/B Temp:     +35.6=B0C  (low  =3D -127.0=B0C, high =3D +127.0=B0C)
temp3:          FAULT  (low  =3D -127.0=B0C, high =3D +127.0=B0C)  ALARM
cpu0_vid:    +1.550 V

Best,
Juergen
>>
>> uname -a
>> Linux wegc203094 3.2.0-4-686-pae #1 SMP Debian 3.2.54-2 i686 GNU/Linux=

>>
>> Best,
>> J=FCrgen
>>

--=20
| J=FCrgen Fuchsberger, M.Sc.
| Wegener Center for Climate and Global Change
| University of Graz
| Brandhofgasse 5, A-8010 Graz, Austria



--ownGU6KuLMNHVoppLGQjFl8dMafxKgDOp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iF4EAREIAAYFAlL5828ACgkQ4RNsce5/DgAZmgEAim5shp18734kuMnMj4RUxNPb
rK5aD00T2Bq8amBlCZoA/3S1mEE5OsWDaCBWgYstu2PzqdV/mCp/rHwh+/NLger4
=a0XK
-----END PGP SIGNATURE-----

--ownGU6KuLMNHVoppLGQjFl8dMafxKgDOp--


--===============0523326258402050076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0523326258402050076==--
