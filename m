From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 08 Jul 2008 05:19:44 +0000
Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
Message-Id: <4872F8F0.3010008@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <486F7926.6000304@kenm.demon.co.uk>
In-Reply-To: <486F7926.6000304@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

George Joseph wrote:
> It's always that last 10% that gets you. :)
>=20
> When I started the driver last year, I cloned one of the LM* drivers and
> it worked just fine for the basic stuff just by modifying the chip and
> manfacturer id.  Then I thought if I'm going to do a driver for this
> thing, I probably should expose as much of the chip's functionality as I
> could.   With 98 registers to read and 160+ sysfs entries to create
> though, =EF=BB=BFI quickly realized it would be impossible to code and ma=
intain
> the driver using the existing paradigms.  Hence the table driven
> approach.  The details of the registers and sysfs entries are all in one
> easy-to-read table.
>=20
> I think at this point the approach will have to stand unless it's going
> to prevent acceptance of the driver.  If it is going to be an issue I
> think I'm just going to have to give up on it for a while.  I only have
> limited windows of time to work on it.
>=20

The table driven approach should not be a problem. Atleast one other driver=
=20
(abituguru3) uses lots of tables too. Disclaimer: I'ven't look (much) at th=
e=20
code yet.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
