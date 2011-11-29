From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 Nov 2011 22:23:15 +0000
Subject: Re: [lm-sensors] [f75387] modifying f75375s module
Message-Id: <20111129232315.282a05fb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <EA28F4E582D7F04DA4E25034DF5AA0FD0BB9DFE5@DEEXVS21.wincor-nixdorf.com>
In-Reply-To: <EA28F4E582D7F04DA4E25034DF5AA0FD0BB9DFE5@DEEXVS21.wincor-nixdorf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, 29 Nov 2011 21:39:00 +0100, Bj=F6rn Gerhart wrote:
> Hi Jean,
>=20
> > Configuration file is case sensitive. You used F75387 with upper-case F
> > in the configuration file while your chip name is f75387 with a
> > lower-case f. Fix that and the configuration section will take effect.
>=20
> Yes, that's it! sensors now works as expected, thanks for the hints  ;-)

You're welcome.

> ..now working on the module source code to support also the origin Fintek=
 chip f75375s again.. May I then provide the patch to you for checkup, or w=
ould the kernel list be the better way to provide it?

The lm-sensors list is better, this is where potential reviewers are.
The kernel list sees so much traffic that odds are nobody would even
notice your posting.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
