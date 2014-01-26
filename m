From: Mark Brown <broonie@kernel.org>
Date: Sun, 26 Jan 2014 21:53:54 +0000
Subject: Re: [lm-sensors] lm90 driver no longer working on PCs in 3.13
Message-Id: <20140126215354.GL11727@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6701251518565412543=="
List-Id: <lm-sensors.vger.kernel.org>
References: <52E561D0.4040308@roeck-us.net>
 <20140126211357.6fa68909@endymion.delvare>
 <52E573B6.9040903@roeck-us.net>
 <20140126214936.7736f530@endymion.delvare>
 <20140126212256.GK11727@sirena.org.uk>
 <52E580CE.8080100@roeck-us.net>
In-Reply-To: <52E580CE.8080100@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, LM Sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Wei Ni <wni@nvidia.com>


--===============6701251518565412543==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDdTYOCAbkFo0FQC"
Content-Disposition: inline


--dDdTYOCAbkFo0FQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 26, 2014 at 01:40:30PM -0800, Guenter Roeck wrote:
> On 01/26/2014 01:22 PM, Mark Brown wrote:

> >What is this platform and why does it have the regulator API enabled in
> >the first place?

> It is a PC running Ubuntu. you'd have to ask the distro maintainers why they
> turn on regulators.

> config-3.8.0-26-generic:CONFIG_REGULATOR=y
> config-3.8.0-35-generic:CONFIG_REGULATOR=y
> config-3.11.0-13-generic:CONFIG_REGULATOR=y

Oh, magic.  Can you please file a bug with or otherwise talk to them
asking them to turn that off (or contribute code to make it work)?  Feel
free to add me as a CC when you do so.

--dDdTYOCAbkFo0FQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5YPuAAoJELSic+t+oim9zb4P/1RGyuj1q68vuy/V5Gi5mpVI
laPfmtnEgieJg6xbCK5Qksep9fh/kBhYjIh34eHnQJC2epxHIL8NRf8q1VV0jmPU
pH4f33QJ2YsN7ohhLr9EVoBmrlml1Kl2Av8cbGks6P+Niun/0J4PqET5zxibJ11v
kkHVPDdvm3guR0A8xaHFPUIihycKXsTbhY+rAdBtw+pp85nrpqJ+EafiG7ECimMk
yIFxilH4/pAam1UBDtJmMn1JdU3I2FwAKIf6zvMJGVGXUu2rTL/4moJFO31WGg+r
yhwzfmpWohqNv4f8Xvu3Zjc8SX9rHBF6BhFyER8/c9TKVTX4RDlyVvqdl0JWRwmd
FloYyC3B3TQvnZL7+H1muuK/QkQt1SFCu9GDf/CMkYd/Mt0JiSISU0hwAA+dsxw5
ZRyKmWuymWrLO8IBPyyRtamzD1pKetPAZ9HQU4uf92KZMKQJ91f+1XN46qy7aZS9
zytsucMN+G+fPZUnmAmbl5lMCOhhcAIxmuYpWOqJ5c3g+5JnpfmFj5nvT4K0kTFz
7zt1IVfYfCP/UomHIhk0qOG7l7aja7Z4vZ7pUAlRSnlQKNNyUrWqDyEVRgG7tBBl
uC1wQV7u8744SfRk4+cl6fmPS2vVSxF4yPWlnqYoFCWgY7SpJ9vWVklI/q33wyh6
0E1p/CD82UZhKvumUcfK
=votX
-----END PGP SIGNATURE-----

--dDdTYOCAbkFo0FQC--


--===============6701251518565412543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6701251518565412543==--
