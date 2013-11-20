From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Nov 2013 17:29:44 +0000
Subject: Re: [lm-sensors] Ticket #2382
Message-Id: <20131120172944.GD28683@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <528A62DC.9030107@baymicrosystems.com>
In-Reply-To: <528A62DC.9030107@baymicrosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Nov 20, 2013 at 10:19:42AM +0100, Jean Delvare wrote:
> Hi Guenter,
>=20
> On Tue, 19 Nov 2013 13:53:58 -0800, Guenter Roeck wrote:
> > On Tue, Nov 19, 2013 at 08:41:01PM +0100, Jean Delvare wrote:
> > [ ... ]
> > > > with the same model/mask. Based on that we could declare a "tjmin" =
and
> > > > report that if it is 1) defined and 2) the valid bit is 0. A somewh=
at "safe"
> > > > temperature to report for the D5xx (model 0x1c/mask 10), based on M=
ike's
> > > > numbers, would then be 36 degrees C (100 - 64).
> > >=20
> > > Not sure where you drew the "36" from. From Mike's table it seems the
> > > valid flag wears off when the reported temperature would be < 6=B0C. =
This
> > > correlates with my findings in the ticket where the valid flag would =
be
> > > 0 for 1=B0C and 4=B0C.
> > >=20
> > Now I remember what I was thinking. In Mike's table, the real temperatu=
re at
> > which the sensor last reported 'valid' (according to the thermal diode)
> > was at 44 degrees C, or 56 degrees below TjMax.
>=20
> That I agree with.
>=20
> > Add the reported temperature
> > of 6 degrees C to that number and you get 62. Round up to 64 below TjMa=
x,
> > or 36 degrees C.
>=20
> All this means is that the DTS would return 0=B0C at approximately 36=B0C
> physical (if we can trust the external sensor AND ignoring the expected
> difference between internal and external temperature measurement.) I
> don't think you can deduce tjmin from that, as the DTS scale and the
> physical scale are distinct.
>=20
Yes, you are right. As I say below, that calculation doesn't really make mu=
ch
sense.

> > Not that this calculation really makes any sense ;-), but with Mike's '=
real'
> > numbers from the thermal diode it sounds at least somewhat reasonable.
>=20
> It is well known that the CPU DTS loses accuracy at low temperatures,
> and Mike's numbers only show that.
>=20
> Tjmin should be taken from the datasheet when it is present there. When
> it is not in the datasheet, it becomes arbitrary, the only hard
> constraint being that it must be greater than the values for which the
> valid flag is no longer set (i.e. >=3D 6 in Mike's case.)
>=20
I don't see it anywhere, and I don't think it exists.

Mike's graph is quite interesting - it shows that the temperature reading e=
rror
is linear, at least for his CPU. Unfortunately, I don't think we can use
that knowledge to "fix" the reading automatically, as the error is very lik=
ely
different for other CPUs. We might consider adding an ideality factor module
parameter, though. What do you think about that ?

Another question is what temperature to use as tjmin. If we add an ideality
factor module parameter, it could be quite low, such as 20 degrees C.
We could even calculate tjmin based on the ideality factor if specified.
    tjmin =3D tjmax - (tjmax * ideality_factor / 100); /* ideality_factor i=
n % */

Otherwise I would prefer something higher, at least 30 degrees C.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
