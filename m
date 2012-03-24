From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 24 Mar 2012 18:07:03 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for  IT8781F, IT8782F, IT8783E/F
Message-Id: <20120324180703.GA3064@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
In-Reply-To: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Mar 24, 2012 at 12:23:13PM -0400, Guenter Roeck wrote:
> Hi Bjoern,
>=20
> At 01:11 AM 3/24/2012, Bj=F6rn Gerhart wrote:
> [ ... ]
>=20
> >     label temp3 "CPU T."
> >     compute temp3 100+@,-1*(100-@)
>=20
> Is it possible that this is due to a bad sensor type configuration ?
>=20
> Thermal diodes have a "current mode" and a=20
> "voltage mode", and if misconfigured (or=20
> miswired) the reported temperature difference is=20
> just about in that range. Difference in wiring,=20
> if I understand it correctly, is that the + pin=20
> is pulled high with a resistor in voltage mode,=20
> which is not the case in current mode.
>=20
> Problem with the wrong reading is that it affects=20
> the sensor's dynamic range. You don't have much=20
> dynamic range left if the reading is off by 100 degrees.
>=20
Hi again,

you might want to check registers 0x56, 0x57, and 0x59.
It might be better to adjust temperature values with those registers
than with sensors.conf, to retain the sensor's dynamic range.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
