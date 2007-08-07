From: Rudolf Marek <r.marek@assembler.cz>
Date: Tue, 07 Aug 2007 07:07:05 +0000
Subject: Re: [lm-sensors] Questions about LPC and HW monitor IC drivers
Message-Id: <46B81A19.5020207@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <5628d8010708050658m7116d3daud9d7450d85da5294@mail.gmail.com>
In-Reply-To: <5628d8010708050658m7116d3daud9d7450d85da5294@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> LPC is Winbond W83697UF, thanks.

Hmm this chip does not seem to have hardware monitoring caps? Are you sure it is
right one? Perhaps the chip is connected elsewhere? Maybe an i2c bus driven by GPIO?

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGuBoZ3J9wPJqZRNURAiWIAJ4+mqHe26zQ/oMVnTN90X6NZo2jkQCeNwZR
g9IV/h40MF1izH+EczdU/b0=+ss3
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
