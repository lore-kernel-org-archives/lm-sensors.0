From: ender@debian.org (David =?iso-8859-1?q?Mart=EDnez=20Moreno?=)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Typo (Re: [PATCH] i2c driver fixes for 2.6.2-rc2)
Message-Id: <200401281408.34364.ender@debian.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <10752464532256@kroah.com>
In-Reply-To: <10752464532256@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

El Mi?rcoles, 28 de Enero de 2004 00:34, Greg KH escribi?:
> +			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
> +				" Defaulting to LM85.\n", verstep);

	Hello, Greg.

	Just noticed, please s,recgonized,recognized,g all over the file.

	Thanks,


		Ender.
- -- 
Oh, I saw...Very American. Fire enough bullets and hope
 they hit the target!
		-- Allan Quatermain (The League of Extraordinary Gentlemen)
- --
Servicios de red - Network services
RedIRIS - Spanish Academic Network for Research and Development
Madrid (Spain)
Tlf (+34) 91.585.51.50
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAF7RSWs/EhA1iABsRAhEvAJ9lEYqh0EkDsDqH12qEcWNRNrUJbACg6zdm
O+T6J0IG3C98iwMhZjh3p8c=jtJ1
-----END PGP SIGNATURE-----

