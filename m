From: Giel van Schijndel <me@mortis.eu>
Date: Tue, 10 Aug 2010 19:11:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: f71882fg: Add support for the
Message-Id: <20100810191117.GN14382@salidar.me.mortis.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6837187752033430649=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20100801132226.GE3711@salidar.me.mortis.eu>
 <1280669402-31213-1-git-send-email-me@mortis.eu>
 <4C5950B6.5010503@redhat.com>
In-Reply-To: <4C5950B6.5010503@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Laurens Leemans <laurens@signips.com>, Jonathan Cameron <jic23@cam.ac.uk>, Randy Dunlap <rdunlap@xenotime.net>, Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org


--===============6837187752033430649==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qd/SZIFVu+MYwfCR"
Content-Disposition: inline


--qd/SZIFVu+MYwfCR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2010 at 01:36:22PM +0200, Hans de Goede wrote:
> On 08/01/2010 03:30 PM, Giel van Schijndel wrote:
>> Allow device probing to recognise the Fintek F71808E.
>>=20
>> Sysfs interface:
>>   * Fan/pwm control is the same as for F71889FG
>=20
> My datasheet strongly disagrees with this ...

I just noticed this patch was applied to mainline anyway.  Regardless, I
will (try to) address these issues you raised.

Right now however, I am prioritising personal stuff above this
driver---bachelor's thesis and graduation presentation.  When finished
with that (september) I'll allocate time to these issues again.

PS Those datasheets are written very poorly, although I have seen worse.
   And as a reader I tend to become more "lazy" when I discover the
   writer was "lazy" (not exactly by choice, more out of habit).
   Unfortunately that doesn't work very well as reading style with
   technical documentation, so this probably explains some of the errors
   in this current patch.

PPS I do have a patch ready that addresses some of the issues you
    raised.  Those are only the cosmetic changes though (e.g. change
    naming of chip, comment updates, etc.).  Would you suggest me to
    send it right now already or wait until I have time to address the
    other issues as well?

--=20
Met vriendelijke groet,
With kind regards,
Giel van Schijndel

--qd/SZIFVu+MYwfCR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkxhpFUACgkQZBYm/87l50Il0wCfciJ9t8+Qd36XoMIFkXDV/dRv
wvgAoL2agAIOAb/Meps3LG5jTkzKPiC+
=iPKZ
-----END PGP SIGNATURE-----

--qd/SZIFVu+MYwfCR--


--===============6837187752033430649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6837187752033430649==--
