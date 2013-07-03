From: David Bartley <andareed@gmail.com>
Date: Wed, 03 Jul 2013 06:42:13 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of NCT6791D
Message-Id: <CAM9zjRMAdEkLN2bNgPGBD36r4CswMiHy73QoHk2OH-h7TAr_+Q@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5100375336162062924=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
To: lm-sensors@vger.kernel.org

--===============5100375336162062924==
Content-Type: multipart/alternative; boundary=047d7b6d82723f406004e095c457

--047d7b6d82723f406004e095c457
Content-Type: text/plain; charset=ISO-8859-1

I can provide register dumps if there's interest, but it seemed like these
read-only registers were mostly just copies of parts of bank 4.


On Tue, Jul 2, 2013 at 11:32 PM, killghost <killghost@msn.com> wrote:

> NCT6791 added 122byte read-only registers for Hardware Monitor. The base
> address is specified in registers
> CR[64h] and CR[65h] of Logical Device B, the hardware monitor device.
> CR[64h] is the high byte, and CR[65h] is
> the low byte. The least byte of the base address recommend to be zero. For
> example, {CR[64h], CR[65h]} =
> {XX00h}.
>
> who know that how to read this data?
>
>
>
> > Date: Wed, 3 Jul 2013 08:23:52 +0200
> > From: khali@linux-fr.org
> > To: linux@roeck-us.net
> > CC: andareed@gmail.com; lm-sensors@lm-sensors.org
>
> > Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of
> NCT6791D
> >
> > On Tue, 2 Jul 2013 19:52:30 -0700, Guenter Roeck wrote:
> > > On Tue, Jul 02, 2013 at 09:10:52AM -0700, David Bartley wrote:
> > > > The value of CR[20]/CR[21] on my board is 0xc8/0x03, and the
> physical chip
> > > > itself has "NCT6791D" printed on it.
> > >
> > > Hi Jean and David,
> > >
> > > Nuvoton confirms that 0xc803 is the correct chip ID.
> >
> > OK, I suppose they will fix it in the next version of the datasheet.
> > Meanwhile you can commit your patch.
> >
> > Thanks,
> > --
> > Jean Delvare
> >
> > _______________________________________________
> > lm-sensors mailing list
> > lm-sensors@lm-sensors.org
> > http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

--047d7b6d82723f406004e095c457
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I can provide register dumps if there&#39;s interest, but =
it seemed like these read-only registers were mostly just copies of parts o=
f bank 4.</div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote=
">On Tue, Jul 2, 2013 at 11:32 PM, killghost <span dir=3D"ltr">&lt;<a href=
=3D"mailto:killghost@msn.com" target=3D"_blank">killghost@msn.com</a>&gt;</=
span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">


<div><div dir=3D"ltr"><div>NCT6791 added 122byte read-only registers for Ha=
rdware Monitor. The base address is specified in registers</div><div>CR[64h=
] and CR[65h] of Logical Device B, the hardware monitor device. CR[64h] is =
the high byte, and CR[65h] is</div>

<div>the low byte. The least byte of the base address recommend to be zero.=
 For example, {CR[64h], CR[65h]} =3D</div><div>{XX00h}.<br><br>who know tha=
t how to read this data?=A0<br><br><br></div><br><div>&gt; Date: Wed, 3 Jul=
 2013 08:23:52 +0200<br>

&gt; From: <a href=3D"mailto:khali@linux-fr.org" target=3D"_blank">khali@li=
nux-fr.org</a><br>&gt; To: <a href=3D"mailto:linux@roeck-us.net" target=3D"=
_blank">linux@roeck-us.net</a><br>&gt; CC: <a href=3D"mailto:andareed@gmail=
.com" target=3D"_blank">andareed@gmail.com</a>; <a href=3D"mailto:lm-sensor=
s@lm-sensors.org" target=3D"_blank">lm-sensors@lm-sensors.org</a><div class=
=3D"im">

<br>&gt; Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of=
 NCT6791D<br>&gt; <br></div><div><div class=3D"h5">&gt; On Tue, 2 Jul 2013 =
19:52:30 -0700, Guenter Roeck wrote:<br>&gt; &gt; On Tue, Jul 02, 2013 at 0=
9:10:52AM -0700, David Bartley wrote:<br>

&gt; &gt; &gt; The value of CR[20]/CR[21] on my board is 0xc8/0x03, and the=
 physical chip<br>&gt; &gt; &gt; itself has &quot;NCT6791D&quot; printed on=
 it.<br>&gt; &gt; <br>&gt; &gt; Hi Jean and David,<br>&gt; &gt; <br>&gt; &g=
t; Nuvoton confirms that 0xc803 is the correct chip ID.<br>

&gt; <br>&gt; OK, I suppose they will fix it in the next version of the dat=
asheet.<br>&gt; Meanwhile you can commit your patch.<br>&gt; <br>&gt; Thank=
s,<br>&gt; -- <br>&gt; Jean Delvare<br>&gt; <br></div></div><div class=3D"i=
m">

&gt; _______________________________________________<br>&gt; lm-sensors mai=
ling list<br>&gt; <a href=3D"mailto:lm-sensors@lm-sensors.org" target=3D"_b=
lank">lm-sensors@lm-sensors.org</a><br>&gt; <a href=3D"http://lists.lm-sens=
ors.org/mailman/listinfo/lm-sensors" target=3D"_blank">http://lists.lm-sens=
ors.org/mailman/listinfo/lm-sensors</a><br>

</div></div> 		 	   		  </div></div>
</blockquote></div><br></div>

--047d7b6d82723f406004e095c457--


--===============5100375336162062924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5100375336162062924==--
