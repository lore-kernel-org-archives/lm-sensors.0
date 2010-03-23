From: Giel van Schijndel <me@mortis.eu>
Date: Tue, 23 Mar 2010 23:26:57 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] [RFC] hwmon: f71882fg: Add watchdog
Message-Id: <20100323232656.GA3605@salidar.me.mortis.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3752528836756171414=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100323141718.GA23172@salidar.me.mortis.eu>
 <1269385936-3440-1-git-send-email-me@mortis.eu>
 <1269385936-3440-2-git-send-email-me@mortis.eu>
 <1269385936-3440-3-git-send-email-me@mortis.eu>
 <1269385936-3440-4-git-send-email-me@mortis.eu>
In-Reply-To: <1269385936-3440-4-git-send-email-me@mortis.eu>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, Laurens Leemans <laurens@signips.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


--===============3752528836756171414==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2010 at 12:12:16AM +0100, Giel van Schijndel wrote:
> Implement the watchdog API for the Fintek F71808E.

Looking at the F71889FG datasheet I think implementing watchdog support
for that chip can be accomplished rather easily.

I think it's as simple as adding the pin initialisation (multi function
select registers 0x2a and 0x2b) sequence to the switch statement in
watchdog_start(). That being said; I don't have physical access to that
chip myself, thus I couldn't actually test it (unlike the F71808E, for
which I've already tested these patches).

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkupTkAACgkQZBYm/87l50IExwCfWZoFKetUqxU5AC36DvRt2EqW
LXEAoLPp/L2JgoWNGQdwGyK5c61F3ZEW
=03zV
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


--===============3752528836756171414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3752528836756171414==--
