From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 11 Jan 2013 18:59:30 +0000
Subject: Re: [lm-sensors] Help to make lm-sensors work with an Asus TUSL2-C
Message-Id: <20130111185929.GA23227@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50DB2017.8010403@tiscali.it>
In-Reply-To: <50DB2017.8010403@tiscali.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, Jan 11, 2013 at 07:03:39PM +0100, Mauro Molinari wrote:
> Il 08/01/2013 14:50, Jean Delvare ha scritto:
> >>Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
> >>Found unknown chip with ID 0x5953
> >>      (logical device 9 has address 0x290, could be sensors)
> >
> >Very strange, I wouldn't expected an unknown Super-I/O chip on such an
> >old board. Can you find the chip's name by visual inspection of the
> >board or from the documentation?
>=20
> Hi Jean!
> I looked at the mainboard again as you suggested. The Super I/O chip
> is a Winbond W83627GF-AW.
>=20
I think that may be W83627SF, not GF. Datasheet is on the web.
If so, it does not support hardware monitoring.

From superiotool source:

	{0x595, "W83627SF", {   /* TODO: Not yet in sensors-detect */

I guess that explains why sensors-detect doesn't recognize it.

Guenter

> In fact, I don't see it in the device support list at lm-sensors.org.
> Are you interested in more information on this?
>=20
> --=20
>=20
> Mauro Molinari
> E-mail: mauromol@tiscali.it
> ICQ UIN: 10379016
> Digital Things Home Space: http://digitalthings.cjb.net
> Il Sito pi=F9 Banale: http://www.poesiamasini.it
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
