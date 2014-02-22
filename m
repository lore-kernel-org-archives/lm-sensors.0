From: Mathias Gerber <mathias_g@tuxedo.ath.cx>
Date: Sat, 22 Feb 2014 14:53:11 +0000
Subject: Re: [lm-sensors] Configuration for Gigabyte Z77-D3H
Message-Id: <5308B9D7.2050500@tuxedo.ath.cx>
List-Id: <lm-sensors.vger.kernel.org>
References: <52D45149.20804@tuxedo.ath.cx>
In-Reply-To: <52D45149.20804@tuxedo.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Jean

On 22.02.2014 10:13, Jean Delvare wrote:
> Beware of "similar boards". We've seen boards with almost the same
> name that had slightly different monitoring setups. Sometimes even
> different hardware revisions of the same board can differ in the
> details. I seem to recall I've even seen once a BIOS update which
> changed one scaling factor as apparently is was wrong originally.
Ok, good to know!

> You should keep a lot of decimals when searching for the scaling=20
> factor. 3.304*12/2.004 is really 19.784431, not 19.78. And 19.78443
> / 12 is closer to 1.649 (Martin Malik's value) than 1.648 (which
> leads to 3.303 V, not matching the BIOS.)
Ok, I fixed it in my local config. I set it now to:
compute in1 @ * (19.78443114/12), @ / (19.78443114/12)
with all decimal places.

> OK, fixed in the wiki.
Thanks

> OK, fixed. Are there other pre-labelled voltage inputs?
Yes, in8 (Vbat) is also labelled. The rest is not.

$ sensors --version
sensors version 3.3.1 with libsensors version 3.3.1

By the way, temp1_input seems to change its value, it does not stay
always at 33=B0C.
Upon bootup I saw values around 25=B0C, climbing up to 33=B0C but then
does not change anymore. Under load or not..

Thanks
- --=20
kind regards
 Mathias
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMIuc8ACgkQnfTEjDUZ2fMLLQCghdK+HtJuoBUIozopKJd91ahg
msMAoKyI/gmv83CMSSsSEVF6pk0OFZQe
=3D2Xku
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
