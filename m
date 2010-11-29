From: no tellin <no.tellin@gmail.com>
Date: Mon, 29 Nov 2010 18:54:03 +0000
Subject: Re: [lm-sensors] ASRock board W83677HG-I
Message-Id: <AANLkTi=v02Y4sgnaVJ8O01OO5JTGhDp=JTAsXu24crgo@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1274168639.7859.20.camel@eee51>
In-Reply-To: <1274168639.7859.20.camel@eee51>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Now I'm very sorry. I replied to the wrong {but related} thread. This
is what I posted in the related thread.

I didn't want to repeat it here, but I'm doing so anyway in order to
keep the pieces together.

"I'm sorry, I just realized I left out an essential part of what I
wanted to post.

I chose to link to a specific example post of mine not only as a
general example, but as a specific example regarding Winbond and fans.

It's my personal experience and observation that with Winbond, lm
sensors will usually display some reasonable values. In those cases
where all the fan values are 0, it usually seems to be a matter of
using the correct divisor.

I especially chose the Asus K8N-DL as the eample because of this very
issue. The generic values {without a motherboard specific
configuration file} displays a default divisor of 2 for all fans and a
value of 0 for same. The K8N-DL not only has a different default
divisor for all fans {4 instead of 2}, but also has a single fan with
an exception {divisor of 1} and also requires further calculation.

I'd suggest you create a motherboard specific configuration file (like
in the example I gave) and try different divisor values."

On Mon, Nov 29, 2010 at 1:25 PM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> To follow up on the original post,
>
> On Mon, 2010-11-29 at 13:14 -0500, no tellin wrote:
>
> [ ... ]
>
>> On Thu, Nov 25, 2010 at 3:38 AM, Andrea Rizzolo
>> <andrea.rizzolo@gmail.com> wrote:
>> > *bump*
>> > Hi, any update? I have the same chip on my Intel DH57JG motherboard an=
d I'm
>> > playing with w83627ehf driver (2.6.36). if I load it with force_id=3D0=
xa510,
>> > running sensors gives me some apparently working output:
>> >
>> > w83667hg-isa-0680
>> > Adapter: ISA adapter
>> > Vcore: =A0 =A0 =A0 +0.93 V =A0(min =3D =A0+0.00 V, max =3D =A0+1.74 V)
>> > in1: =A0 =A0 =A0 =A0 +0.77 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.00 =
V) =A0 ALARM
>> > AVCC: =A0 =A0 =A0 =A0+3.41 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.00 =
V) =A0 ALARM
>> > +3.3V: =A0 =A0 =A0 +3.41 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.00 V)=
 =A0 ALARM
>> > in4: =A0 =A0 =A0 =A0 +1.26 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.00 =
V) =A0 ALARM
>> > in5: =A0 =A0 =A0 =A0 +0.78 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.00 =
V) =A0 ALARM
>> > 3VSB: =A0 =A0 =A0 =A0+3.36 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.00 =
V) =A0 ALARM
>> > Vbat: =A0 =A0 =A0 =A0+3.30 V =A0(min =3D =A0+0.00 V, max =3D =A0+0.00 =
V) =A0 ALARM
>> > fan1: =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM, div =3D 2) =
=A0ALARM
>> > fan2: =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM, div =3D 2) =
=A0ALARM
>> > fan3: =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM, div =3D 2) =
=A0ALARM
>> > fan5: =A0 =A0 =A0 =A0 =A00 RPM =A0(min =3D =A0 =A00 RPM, div =3D 2) =
=A0ALARM
>> > temp1: =A0 =A0 =A0 +29.0 C =A0(high =3D =A0+0.0 C, hyst =3D =A0+0.0 C)=
 =A0ALARM =A0sensor >> > diode
>> > temp2: =A0 =A0 =A0 +30.5 C =A0(high =3D +80.0 C, hyst =3D +75.0 C) =A0=
sensor =3D diode
>> > temp3: =A0 =A0 =A0 +23.0 C =A0(high =3D +80.0 C, hyst =3D +75.0 C) =A0=
sensor =3D thermistor
>> > cpu0_vid: =A0 +2.050 V
>> >
>
> Key difference between the W83677HG-I is fan register access, so the
> result isn't surprising. Adding support for fans will be the tricky
> part.
>
> Guenter
>
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
