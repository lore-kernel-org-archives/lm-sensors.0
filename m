From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Mon, 27 Apr 2015 18:39:08 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/2] i8k.c => dell-smm-hwmon.c
Message-Id: <201504272039.08549@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1723198720519706579=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com> <20150421152400.GA14723@roeck-us.net> <20150421153016.GB28122@kroah.com>
In-Reply-To: <20150421153016.GB28122@kroah.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============1723198720519706579==
Content-Type: multipart/signed;
  boundary="nextPart3683366.tTBITMWZVM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3683366.tTBITMWZVM
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 21 April 2015 17:30:16 Greg Kroah-Hartman wrote:
> On Tue, Apr 21, 2015 at 08:24:00AM -0700, Guenter Roeck wrote:
> > On Tue, Apr 21, 2015 at 03:52:06PM +0200, Greg Kroah-Hartman
> > wrote:
> > > On Tue, Apr 21, 2015 at 06:40:57AM -0700, Guenter Roeck
> > > wrote:
> > > > On 04/21/2015 06:30 AM, Pali Roh=C3=A1r wrote:
> > > > >On Thursday 09 April 2015 16:02:24 Pali Roh=C3=A1r wrote:
> > > > >>On Tuesday 31 March 2015 15:56:01 Greg Kroah-Hartman
> > > > >>wrote:
> > > > >>>On Mon, Mar 30, 2015 at 08:32:36PM -0700, Guenter
> > > > >>>Roeck wrote:
> > > > >>>>On 03/29/2015 05:57 AM, Pali Roh=C3=A1r wrote:
> > > > >>>>>This patch series moves drivers/char/i8k.c to
> > > > >>>>>drivers/hwmon/dell-smm-hwmon.c and allows to
> > > > >>>>>compile hwmon driver without /proc/i8k file.
> > > > >>>>>
> > > > >>>>>Pali Roh=C3=A1r (2):
> > > > >>>>>   hwmon: Rename i8k driver to dell-smm-hwmon and
> > > > >>>>>   move it to hwmon tree hwmon: Allow to compile
> > > > >>>>>   dell-smm-hwmon driver without /proc/i8k
> > > > >>>>> =20
> > > > >>>>>  MAINTAINERS                    |    4 +-
> > > > >>>>>  arch/x86/Kconfig               |   25 +-
> > > > >>>>>  drivers/char/Makefile          |    1 -
> > > > >>>>>  drivers/char/i8k.c             | 1005
> > > > >>>>>  ---------------------------------------
> > > > >>>>>  drivers/hwmon/Kconfig          |   11 +
> > > > >>>>>  drivers/hwmon/Makefile         |    1 +
> > > > >>>>>  drivers/hwmon/dell-smm-hwmon.c | 1025
> > > > >>>>>  ++++++++++++++++++++++++++++++++++++++++ 7 files
> > > > >>>>>  changed, 1049 insertions(+), 1023 deletions(-)
> > > > >>>>>  delete mode 100644 drivers/char/i8k.c
> > > > >>>>>  create mode 100644 drivers/hwmon/dell-smm-hwmon.c
> > > > >>>>
> > > > >>>>I am ok with the series and would take it for 4.1 if
> > > > >>>>Greg agrees.
> > > > >>>>
> > > > >>>>Greg, any comments ?
> > > > >>>
> > > > >>>Let me review it, it's in my queue...
> > > > >>
> > > > >>Hi Greg! Have you looked at it?
> > > > >
> > > > >Greg & Guenter: ping. Will you include it into 4.1?
> > > >=20
> > > > I don't see it in Greg's pull request, so presumably no
> > > > (unless I missed it).
> > >=20
> > > No, I missed it for this rc cycle, sorry.  If you want to
> > > include it in yours, by all means please do so.
> >=20
> > Too late; I sent my pull request early last week. Also,
> > since I don't have the patch in my queue, it would not
> > follow my own process, and I really dislike doing that.
>=20
> Ok, as this is "just" a rename, I'll see about doing it for
> -rc2, that way we avoid the merge issues.
>=20
> thanks,
>=20
> greg k-h

Hi Greg, -rc1 was released. Do not forget to include it for -rc2=20
pull request.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3683366.tTBITMWZVM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlU+gkwACgkQi/DJPQPkQ1L11wCfUDRozJIyM8JBtsnZyt081TTF
Zr4AniIbJkt2Xz5w/wrrdC/CCi8a0el0
=Dlbz
-----END PGP SIGNATURE-----

--nextPart3683366.tTBITMWZVM--


--===============1723198720519706579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1723198720519706579==--
