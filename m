From: Jean-Denis Girard <jd.girard@sysnux.pf>
Date: Wed, 17 Aug 2011 07:59:42 +0000
Subject: Re: [lm-sensors] Alix 2D2
Message-Id: <4E4B74EE.50100@sysnux.pf>
List-Id: <lm-sensors.vger.kernel.org>
References: <4E4A9BEE.5030108@sysnux.pf>
In-Reply-To: <4E4A9BEE.5030108@sysnux.pf>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Le 16/08/2011 20:24, Guenter Roeck a =E9crit :
> Looking into the i2c bus driver code, it was recently converted into a pl=
atform driver.
> The supporting mfd driver would be cs5535-mfd. That might be one possible=
 reason
> for your problem, though it happened less than a year ago.

Thanks Guenter, that was my problem (cs5535_mfd missing); now it is
working again:
[admin@ix100 ~]$ sensors
lm86-i2c-0-4c
Adapter: CS5535 ACB0
temp1:        +43.0=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)
                       (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)
temp2:        +49.8=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)
                       (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)

Shouldn't scx200_acb depend on cs5535_mfd in the kernel configuration
options ?


Thanks,
- --=20
Jean-Denis Girard

SysNux                  Syst=E8mes  Linux  en Polyn=E9sie fran=E7aise
http://www.sysnux.pf/   T=E9l: +689 50 10 40 / GSM: +689 79 75 27
-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAk5LdO4ACgkQuu7Rv+oOo/hcEwCgi4JMDKMbWTHEgqasEVMJTM4p
4EUAn0U1hNskUxTnBcoUJ7OH/amwx70u
=3D/tZA
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
