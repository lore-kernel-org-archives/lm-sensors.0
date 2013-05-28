From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 28 May 2013 13:47:49 +0000
Subject: Re: [lm-sensors] [PATCHv2 0/3] Add G762/G763 PWM fan controller
Message-Id: <20130528134734.GA12585@mithrandir>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2261435635937802230=="
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1369687670.git.arno@natisbad.org>
 <152190814.eApXVbVBPA@wuerfel>
 <87li6z2yxj.fsf@natisbad.org>
 <20130528111921.GD11547@mithrandir>
 <20130528122940.GA29012@roeck-us.net>
In-Reply-To: <20130528122940.GA29012@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnaud Ebalard <arno@natisbad.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Simon Guinot <simon.guinot@sequanux.org>


--===============2261435635937802230==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2013 at 05:29:40AM -0700, Guenter Roeck wrote:
> On Tue, May 28, 2013 at 01:19:23PM +0200, Thierry Reding wrote:
> > On Tue, May 28, 2013 at 12:15:04PM +0200, Arnaud Ebalard wrote:
> > > Hi Arnd,
> > >=20
> > > Arnd Bergmann <arnd@arndb.de> writes:
> > >=20
> > > > On Tuesday 28 May 2013 00:02:29 Arnaud Ebalard wrote:
> > > >>=20
> > > >> This series adds support for GMT G762/G763. This work is based on a
> > > >> basic version for 2.6.31 kernel developed Olivier Mouchet for LaCie
> > > >> NAS. Updates have been performed to run on recent kernels. Support=
 has
> > > >> been completed and additional features added: ability to configure
> > > >> various characteristics from .dts file, better initialization, ala=
rms
> > > >> and error reporting support, gear mode, polarity, fan pulse per
> > > >> revolution, fan startup voltage control.
> > > >
> > > > I wonder if this could be split into two separate drivers, one for
> > > > the pwm subsystem, and one for a hardware-independent fan controller
> > > > based on the pwm interfaces.
> > >=20
> > > To be honest, I wouldn't even know how to start in order to do that.
> > > Additionally, it would be worth the effort if other drivers could be
> > > easily refactored using this idea. I'll let hwmon people provide some
> > > feedback and try and comply with their directions (based on the cpu
> > > cycle I can spend on this).
> >=20
> > What Arnd proposes doesn't sounds like a very good idea. PWM-controlled
> > fans should be able to work just fine using a generic driver that uses
> > the PWM framework, similar to the PWM backlight and LED drivers.
> >=20
> Isn't that exactly what Arnd proposed ?

Oh, right. I meant to say: "What Arnd proposes sounds like a very good
idea." =3D) Sorry for the confusion.

Thierry

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRpLV2AAoJEN0jrNd/PrOhyOgQAJqTm4dEvj+1M1JQF0/Szq4a
T5trBhOqWmOyRSNu69anl628qh1wzuAt1RkjMAZwnxh3YF4DmYooE0LG9FQ+b3z1
a9gphjKVon64eB+4Fe2Of0ykulVkkYxO5bBWaYB2WtqNQk2wifdHD33jkrJFg8PJ
15hoPY2QxmbvIHtTzVhrysObDqY2TLefMnxgbeVJMKrQGaCcw/aW5eI5/VnYeBTj
VLdXSKwMTQqONupDBRBiBN3evJZm0eWWQXOf+K99I8yNzpm7enQ27nvlpA1/2m5h
tVPaSBfqUjNE0I3QyOztHBUR6G0NFPEEyHjrXlznaBFsAN8DJ3j7LuqborNr6Aul
l+5/cb4do7YNoL3zL44IkDTkWodInVQBkiQ0O4Urlz+Bx/zex7jmxciY5kvmgm5L
ZDKIl2K/SSlRJEPLDI3CV51bRWg9gOxoYK5DsGjr9dbVBCeoAKECvBX8kpiiI+RU
5oWUAdNYGAlizE9TwrW4VNIqlK1jAu2Dqxkw1nVf5kEwlFVgq8J8LuYKoI6Dr/a7
M/q+t3KrMAzB83Z/ptbHibnxlKfRvLQ7pe5SS52T+r3Ek0uHmQGjEr830gTcF/JT
7URhAOX4PellAhEUHDK1vY6hhXHho5iNmMeu8z1TLVNaHCWh/S7y3+pSig3eBL1u
sRYVj8PwVuBI046usgH6
=woXh
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--


--===============2261435635937802230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2261435635937802230==--
