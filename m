From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Apr 2007 11:23:06 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070409132306.c2ec9328.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sun, 08 Apr 2007 20:56:30 +0200, Hans de Goede wrote:
> Hans-J=FCrgen Koch wrote:
> > Am Sonntag 08 April 2007 19:36 schrieb Hans de Goede:
> >> Last but not least doing things this way allows me to always give=20
> >> a proper reading without userspace needing to "guess" any further
> >> nescesarry calculations to get from the reading to an actual measureme=
nt.
> >=20
> > I agree that this is convenient, especially when reading sysfs values e=
.g.
> > from a script (without a library that could do table lookups). This is
> > probably a strong argument in favor of your table solution.
>=20
> Yes its very convinient, in an ideal world all hwmon drivers would do thi=
s and=20
> libsensors would not be necessary.

Wrong. Conversions belong to user-space. We must only put in the kernel
as little as possible. This is a golden rule. The current design with a
user-space library is the right way to do. If you think it makes it
hard to write shell scripts that manipulate hardware monitoring data,
it means the library is not properly designed and/or we are missing a
few helper programs. This is an implementation problem, not a design
problem.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
