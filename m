From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Apr 2007 11:27:21 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070409132721.86acf12c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 08 Apr 2007 19:36:47 +0200, Hans de Goede wrote:
> Hans-J=FCrgen Koch wrote:
> > Am Sonntag 08 April 2007 15:51 schrieb Hans de Goede:
> >=20
> >> The abituguru3 has a register which contains a motherboard ID. The cur=
rent
> >> driver uses this ID, to look up info about the motherboard in a somewh=
at
> >> lenght table in the driver.=20
> >=20
> > Can you elaborate your design decision a bit? My first idea would be to=
 have
> > a sysfs file that delivers that motherboard ID and then do the lookup in
> > user space.

I guess that the motherboard ID can be retrieved in user-space using
dmidecode, can't it? So it might not even be needed to export it.

> As I don't want the abituguru3 driver to create entries in sysfs for sens=
ors=20
> which aren't there, and as without the table in the driver I cannot be su=
re=20
> wether to create an in / temp / fan device for a given sensor address. La=
st but=20
> not least doing things this way allows me to always give a proper reading=
=20
> without userspace needing to "guess" any further nescesarry calculations =
to get=20
> from the reading to an actual measurement.

This is absolutely not different from all other hardware monitoring
drivers. And all other drivers handle it in user-space, because that's
the right design. I see no valid reason why it would be different for
your abituguru3 driver. All you need is one configuration file per
motherboard.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
