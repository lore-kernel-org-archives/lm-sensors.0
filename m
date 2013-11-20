From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Nov 2013 09:19:42 +0000
Subject: Re: [lm-sensors] Ticket #2382
Message-Id: <20131120101942.6680962b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <528A62DC.9030107@baymicrosystems.com>
In-Reply-To: <528A62DC.9030107@baymicrosystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Tue, 19 Nov 2013 13:53:58 -0800, Guenter Roeck wrote:
> On Tue, Nov 19, 2013 at 08:41:01PM +0100, Jean Delvare wrote:
> [ ... ]
> > > with the same model/mask. Based on that we could declare a "tjmin" and
> > > report that if it is 1) defined and 2) the valid bit is 0. A somewhat=
 "safe"
> > > temperature to report for the D5xx (model 0x1c/mask 10), based on Mik=
e's
> > > numbers, would then be 36 degrees C (100 - 64).
> >=20
> > Not sure where you drew the "36" from. From Mike's table it seems the
> > valid flag wears off when the reported temperature would be < 6=B0C. Th=
is
> > correlates with my findings in the ticket where the valid flag would be
> > 0 for 1=B0C and 4=B0C.
> >=20
> Now I remember what I was thinking. In Mike's table, the real temperature=
 at
> which the sensor last reported 'valid' (according to the thermal diode)
> was at 44 degrees C, or 56 degrees below TjMax.

That I agree with.

> Add the reported temperature
> of 6 degrees C to that number and you get 62. Round up to 64 below TjMax,
> or 36 degrees C.

All this means is that the DTS would return 0=B0C at approximately 36=B0C
physical (if we can trust the external sensor AND ignoring the expected
difference between internal and external temperature measurement.) I
don't think you can deduce tjmin from that, as the DTS scale and the
physical scale are distinct.

> Not that this calculation really makes any sense ;-), but with Mike's 're=
al'
> numbers from the thermal diode it sounds at least somewhat reasonable.

It is well known that the CPU DTS loses accuracy at low temperatures,
and Mike's numbers only show that.

Tjmin should be taken from the datasheet when it is present there. When
it is not in the datasheet, it becomes arbitrary, the only hard
constraint being that it must be greater than the values for which the
valid flag is no longer set (i.e. >=3D 6 in Mike's case.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
