From: Mark Brown <broonie@kernel.org>
Date: Sat, 23 Aug 2014 15:53:06 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] pmbus: ltc2978: add regulator gating
Message-Id: <20140823155306.GN24407@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0583115774758424891=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1408741894-24879-1-git-send-email-atull@opensource.altera.com>
 <1408741894-24879-3-git-send-email-atull@opensource.altera.com>
 <20140822214546.GD24407@sirena.org.uk>
 <53F8AED8.8010908@roeck-us.net>
In-Reply-To: <53F8AED8.8010908@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: atull@opensource.altera.com, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com


--===============0583115774758424891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e+CieX+hyvUQgATU"
Content-Disposition: inline


--e+CieX+hyvUQgATU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 23, 2014 at 08:10:16AM -0700, Guenter Roeck wrote:

> Sorry I didn't have time to review the code myself. I'll have
> to check the datasheet about turning regulators on and off.
> Using page 0xff for the lm2978 looks wrong, as the chip supports
> up to 8 channels which should be controlled separately
> (I would assume) instead of turning them all on and off in
> one go. Maybe I am missing something, but my assumption would
> have been to have a separate regulator for each channel, and
> that each channel would have its own regulator which would be

BTW I should point out that my review is just for the regulator API
aspects of the change, I have no knowledge of this hardware.  If what
you're saying matches the hardware I'd definitely expect to see one
regulator registered per physical regulator rather than a single
regulator for everything on the device.

--e+CieX+hyvUQgATU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT+LjfAAoJELSic+t+oim9f5gP+wV8Oqtw7TW5LoRKUuCSpBkE
8LBhtI54Mm5nKIo9YpEggAt3xCnKO9+zy7XzMJG3JVv1KjXVwn+gEYtLSv6cZfYl
HKYWM2T719KKJciBECFLzBG4t86sJMHMkSGhQ3Nx0kr2n/9Y5heIvIK9kZzqpTq1
R7wrudCaID5Vi4j88h/GjztfSbEnDRJqKEVnBvhA8hjSw/Spdz+9zBnLnIivcXLZ
VQxaid0ild9t8xRoR//hkkB3beScy+6CHUlUey9UmIJbOxF5jN/ocoj5hRmU+LoH
BQL0x4fHZgKb2l5dwxHLqh0WUNM4rlUj2lGc1tCY8zomOd7vr2CI2fDqtoUK20Sy
VFMMUFM5HdW6E8z19I88v0bN8vHAc9t7TF22nixCkK9cTpHAYOXhR4BIXZtlS6nE
eyoUYfa1vLezO40tufmJdjBbzRwcjsMeQoNZ36d9CcPtmdPkxFFtyZHsyGion2kt
iqo444RmpPW/eDl8iL0EmEAta4Pv1OFh67qPLSNqpX2ICaH4YxYabVvzl2Bxxtn+
C/cZHJiQ0HdaF0kTtlbOO4/FmFnUmACftRJs49Ms5dztHEaFKf5pNFQQOayV/ehn
XB24uIf9Q4h73UK2gBJLi5STIPtmD5JDxXRPt655ZqVHwe4cgK04r8td5Wl70KIl
Bo0g/dDsnlQBxIkwnsb0
=d7q8
-----END PGP SIGNATURE-----

--e+CieX+hyvUQgATU--


--===============0583115774758424891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0583115774758424891==--
