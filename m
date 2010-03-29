From: Giel van Schijndel <me@mortis.eu>
Date: Mon, 29 Mar 2010 08:18:34 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] resource: shared I/O region support
Message-Id: <20100329081834.GB27956@salidar.me.mortis.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5806715700700638213=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100325125005.6d58cfaf@lxorguk.ukuu.org.uk>
 <1269523063-30346-1-git-send-email-me@mortis.eu>
 <20100325155705.1ec79dbc@lxorguk.ukuu.org.uk>
 <20100325180347.GA2761@salidar.me.mortis.eu>
 <20100325181633.0313b8a5@lxorguk.ukuu.org.uk>
In-Reply-To: <20100325181633.0313b8a5@lxorguk.ukuu.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Hans de Goede <hdegoede@redhat.com>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Jesse Barnes <jbarnes@virtuousgeek.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


--===============5806715700700638213==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 25, 2010 at 06:16:33PM +0000, Alan Cox wrote:
>> +			if (res->flags & IORESOURCE_MUXED)
>> +				wake_up(&muxed_resource_wait);
>>  			kfree(res);
>>  			return;
>=20
> And you'll want a
>=20
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Yes, thanks.

Anyone specific I should mail to get this patch applied? I don't see any
entry in MAINTAINERS for kernel/resource.c or include/linux/resource.h.

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuwYloACgkQZBYm/87l50KTQgCfa3h3wuB8x3C+4CKz4FsLeNC7
smsAn0Rc1YY58KMBUkHB94P15ho4ms+r
=c6WC
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--


--===============5806715700700638213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5806715700700638213==--
