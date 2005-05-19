From: poll2@poczta.fm (-= Poll =-)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Kconfig patch
Message-Id: <200402072051.34663.poll2@poczta.fm>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040207201818.6522e689.khali@linux-fr.org>
In-Reply-To: <20040207201818.6522e689.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 07 February 2004 20:18, Jean Delvare wrote:
> Working? You must be kidding. Your patch does not do what you say it
> does. And I2C_ISA *does* depend on I2C, although it doesn't depend on
> ISA, as previous kernels pretended. I suspect that your patch was meant
> to fix that already solved problem.
>
> Let me know if I missed something.

Argh... Sorry :) You have right. depending on ISA was in 2.6.1, and now i just 
clean I2C instead ISA. Sorry for mess. I shiuld shame on me ... :(

- -- 
- -= Poll =-

LinuX registered user no.: #239322
PGP Key Id 0xb7edd892 at http://pgp.mit.edu
JID: poll[]at[]chrome[]dot[]pl
GG: 4644930
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJUHEdOxfmLft2JIRArKpAJ4/CuzdeOjlQAjbAQQ79DK9R4MCFACfVUWg
1SjLpJMoXOO5n872+ge+tHU=vi9v
-----END PGP SIGNATURE-----

