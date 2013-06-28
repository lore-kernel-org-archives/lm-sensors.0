From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 28 Jun 2013 13:41:54 +0000
Subject: Re: [lm-sensors] [lm-sensors 1/2] hwmon: (ds1621) Add ds1721 chip support
Message-Id: <20130628134154.GA23217@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368078354-26298-2-git-send-email-rob.coulson@gmail.com>
In-Reply-To: <1368078354-26298-2-git-send-email-rob.coulson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jun 28, 2013 at 02:05:26PM +0200, Jean Delvare wrote:
> On Thu, 27 Jun 2013 10:12:51 -0700, Guenter Roeck wrote:
> > On Thu, Jun 27, 2013 at 10:36:31AM +0200, Jean Delvare wrote:
> > > This breaks limit rounding on the DS1621. Limits have a resolution of
> > > 0.5=B0C on that chip, so limit values should rounded to the closest
> > > half-degree. It used to work but no longer: if I write 20300 to
> > > temp1_min, it is rounded down to 20000, while it should be rounded up
> > > to 20500.
> >=20
> > Can you test the following patch ? It follows the logic implemented in =
the
> > tmp401 driver.
>=20
> Tested OK, thanks :)
>=20
> Tested-by: Jean Delvare <khali@linux-fr.org>
>=20
> And as the code looks sane too:
>=20
> Acked-by: Jean Delvare <khali@linux-fr.org>
>=20
Thanks, to keep simple I'll add it on top of my -next tree instead of mergi=
ng it.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
