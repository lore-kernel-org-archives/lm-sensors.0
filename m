From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 27 Jul 2006 01:31:12 +0000
Subject: [lm-sensors] [RFC PATCH] lib/access.c optimization
Message-Id: <20060727013112.GC25291@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060725041358.GB12109@jupiter.solarsys.private>
In-Reply-To: <20060725041358.GB12109@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi again:

* Mark M. Hoffman <mhoffman at lightlink.com> [2006-07-25 00:13:58 -0400]:
> The following patch shaves about 8% off the execution time of 'sensors -u'
> on my workstation (2645586 cycles before vs. 2430821 cycles after).
>=20
> Can I please get an ACK on this patch before I commit it?  Thanks.
>=20
> Measurement method:
> 	(build/install lm-sensors userspace with DEBUG=3D1 to get -g)
> 	valgrind --tool=CAllgrind sensors -u
> 	kcachegrind callgrind.out.NNNN
>=20
>=20
> Index: lib/access.c

Before anyone spends too much time on that patch... why are there so many
'strcasecmp' calls in libsensors?  Did you know that you can specify 'in0'
or 'IN0' in the config file and both have the same effect?  I never even
realized it until yesterday night.  This case insensitivity is *nowhere*
mentioned in the man pages.

Can we get rid of that?  If so, I'm gonna shave a lot more than 8% by
using a hash for all the string/name to chip/feature/ignore lookups.

BTW: valgrind 3.2.0 (w/ callgrind) plus kcachegrind rocks.

Regards,

--=20
Mark M. Hoffman
mhoffman at lightlink.com


