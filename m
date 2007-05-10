From: Stephen Cormier <s.cormier@gmx.net>
Date: Thu, 10 May 2007 18:46:22 +0000
Subject: Re: [lm-sensors]
Message-Id: <200705101546.22231.s.cormier@gmx.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6008455083938091315=="
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
To: lm-sensors@vger.kernel.org

--===============6008455083938091315==
Content-Type: multipart/signed; boundary="nextPart2196958.z3QQzTiUem";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2196958.z3QQzTiUem
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On May 10, 2007 01:36:31 pm Dieter Rogiest wrote:
> My cpu is an Athlon 64 X2 Dual core 5600+.
> I installed lm_sensors-2.10.2 on Mandriva Linux 2007.1.
>
> When I run sensors I get these temperatures:
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>              +17=B0C
> Core1 Temp:
>              +25=B0C
>
> How come temperature of Core0 is so low? Does this mean that Core0 is not
> used by my kernel (uname -r: 2.6.20.11-tmb-desktop-1mdvsmp )?
> What programs should I use so that Core0 is also used
> Are there shell commands by which I can let Core0 and Core1 work to their
> maximum?

=46rom the looks of it both cores work as shown by your other post. When I =
had=20
both of the Opterons I ran in my 939 board they showed the same thing you s=
ee=20
one of the cores was always at least 8 or 10 C higher than the other now wi=
th=20
my X2 3800 (512k cache) they are within a degree of each other at all times=
=2E=20
I checked and seen the chip you have has the same 1mb cache as the Opterons=
=20
so I would go with the idea that is how them chips run, one core always muc=
h=20
hotter than the other since this would be three that I have seen the=20
temperatures for and they all have the same type of readings.

> Dieter
>

Stephen

=2D-=20
GPG Pubic Key: http://users.eastlink.ca/~stephencormier/publickey.asc

--nextPart2196958.z3QQzTiUem
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGQ2h+jgQLPii62a8RAimQAJ9HTQK1x3YeYs0oX6kgnd+VmRVX+ACgt2zp
ZzqA75dRQtY4biXvvq2zkx8=
=7eMB
-----END PGP SIGNATURE-----

--nextPart2196958.z3QQzTiUem--


--===============6008455083938091315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6008455083938091315==--
