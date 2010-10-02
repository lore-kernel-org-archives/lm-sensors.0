From: Giel van Schijndel <me@mortis.eu>
Date: Sat, 02 Oct 2010 22:59:58 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: f71882fg: use a muxed resource
Message-Id: <20101002225958.GA18605@salidar.me.mortis.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8950938555539546730=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100801132226.GE3711@salidar.me.mortis.eu>
 <1280669455-31283-1-git-send-email-me@mortis.eu>
 <4C59514A.7090401@redhat.com>
In-Reply-To: <4C59514A.7090401@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurens Leemans <laurens@signips.com>, Jonathan Cameron <jic23@cam.ac.uk>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, 597820@bugs.debian.org


--===============8950938555539546730==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2010 at 01:38:50PM +0200, Hans de Goede wrote:
> Ack!
>=20
> Acked-by: Hans de Goede <hdegoede@redhat.com>
>=20
> On 08/01/2010 03:30 PM, Giel van Schijndel wrote:
>> Sleep while acquiring a resource lock on the Super I/O port. This should
>> prevent collisions from causing the hardware probe to fail with -EBUSY.
>>=20
>> Signed-off-by: Giel van Schijndel<me@mortis.eu>

Would anyone please apply this patch?  It's been sitting for quite some
time now collecting dust (none of that fictional bit-rot thus far
however).  If this patch needs to be resubmitted or requires me to poke
a specific individual please let me know (and what individual to poke).

FYI the Message-ID of that patch is:
<1280669455-31283-1-git-send-email-me@mortis.eu>

PS I've added Guenter Roeck and Andrew Morton to the CC list because
   between now and the original submission date they got appended to
   scripts/get_maintainer.pl's output.

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel
--
"It would seem that perfection is attained not when no more can be
 added, but when no more can be removed."
  -- Antoine de Saint Exup=C3=A9ry

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkynuWsACgkQZBYm/87l50LG4ACaA+M3Mw18quNSpk88jmT3kk+U
zCoAoJsIgV+UNmHv/ED/wwQtWEJKVAHc
=DLEW
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--


--===============8950938555539546730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8950938555539546730==--
