From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 08 Jul 2009 20:40:05 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for Penryn mobile CPUs
Message-Id: <4A550425.6080705@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A5228B8.7010604@assembler.cz>
In-Reply-To: <4A5228B8.7010604@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> Logic is invalid: if there's an error then the value of edx is
> undefined.


Yes I know, but there was no place I could create this variable. Perhaps I need
to re-think it a bit. Maybe on sunday evening :/

Anyway thanks for the review! I will try to fix it somehow.

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpVBCUACgkQ3J9wPJqZRNXSIQCfYZdeRqvNDsbbU/navL/P332x
BuoAn2aQNMCTsx0Vors75IlnZPZqtK1J
=7GW2
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
