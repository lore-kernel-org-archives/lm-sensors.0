From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: formula for calculating cpu temp with ASUS cusl2-c
Message-Id: <200304261205.00380.vgmarimon@terra.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304252010.06867.vgmarimon@terra.es>
In-Reply-To: <200304252010.06867.vgmarimon@terra.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El S?bado, 26 de Abril de 2003 10:19, escribi?:
>
> Thanks for the formula. Asus has been using many different ones on their
> different motherboards, which is causing some trouble.
>
> I think we will use the following line instead:
>
> compute temp2 (@*60/43)+25,(@-25)*43/60
>
> Because it looks really like the other known formula, and I doubt it's a
> coincidence.
>
> Is your board for an Intel or AMD cpu?

	it's for Intel  socket 370 type with chipset intel 815EP and 866Mhz cpu

> How recent is it?

	2 or 3 years

- -- 
Victor G. Marimon
Miembro de Bulma (http://bulmalug.net)
Usando Gentoo Linux 1.4
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+qlnLmAtZm4z1xakRAtfFAKChNVoxC8aApVwratN6jnENE5PGfACePHnx
VPylAVASqF55xt/+7JWd3y0=vzHR
-----END PGP SIGNATURE-----

