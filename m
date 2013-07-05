From: David Bartley <andareed@gmail.com>
Date: Fri, 05 Jul 2013 07:16:43 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of NCT6791D
Message-Id: <CAM9zjROp8SgXF0Y=oF+pBqcn_BTx83JVoKCWa=zxXk6v4eD2cQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2492140836923902468=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
To: lm-sensors@vger.kernel.org

--===============2492140836923902468==
Content-Type: multipart/alternative; boundary=047d7b86f03677191704e0be7b5a

--047d7b86f03677191704e0be7b5a
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jul 3, 2013 at 1:26 AM, killghost <killghost@msn.com> wrote:

> I need this,and How to read ?
>

http://csclub.uwaterloo.ca/~dtbartle/nct6791d/



> ------------------------------
> From: andareed@gmail.com
> Date: Tue, 2 Jul 2013 23:42:13 -0700
>
> Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of NCT6791D
> To: killghost@msn.com
> CC: khali@linux-fr.org; linux@roeck-us.net; lm-sensors@lm-sensors.org
>
>
> I can provide register dumps if there's interest, but it seemed like these
> read-only registers were mostly just copies of parts of bank 4.
>
>
> On Tue, Jul 2, 2013 at 11:32 PM, killghost <killghost@msn.com> wrote:
>
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
>
>

--047d7b86f03677191704e0be7b5a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Wed, Jul 3, 2013 at 1:26 AM, killghost <span dir=3D"ltr=
">&lt;<a href=3D"mailto:killghost@msn.com" target=3D"_blank">killghost@msn.=
com</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">





<div><div dir=3D"ltr">I need this,and How to read ?<br></div></div></blockq=
uote><div><br></div><div><a href=3D"http://csclub.uwaterloo.ca/~dtbartle/nc=
t6791d/" target=3D"_blank">http://csclub.uwaterloo.ca/~dtbartle/nct6791d/</=
a></div>


<div><br></div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div>
<div dir=3D"ltr"><div><hr>From: <a href=3D"mailto:andareed@gmail.com" targe=
t=3D"_blank">andareed@gmail.com</a><br>Date: Tue, 2 Jul 2013 23:42:13 -0700=
<div><br>Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of=
 NCT6791D<br>


</div>To: <a href=3D"mailto:killghost@msn.com" target=3D"_blank">killghost@=
msn.com</a><br>CC: <a href=3D"mailto:khali@linux-fr.org" target=3D"_blank">=
khali@linux-fr.org</a>; <a href=3D"mailto:linux@roeck-us.net" target=3D"_bl=
ank">linux@roeck-us.net</a>; <a href=3D"mailto:lm-sensors@lm-sensors.org" t=
arget=3D"_blank">lm-sensors@lm-sensors.org</a><div>


<div><br><br><div dir=3D"ltr">I can provide register dumps if there&#39;s i=
nterest, but it seemed like these read-only registers were mostly just copi=
es of parts of bank 4.</div><div><br><br><div>On Tue, Jul 2, 2013 at 11:32 =
PM, killghost <span dir=3D"ltr">&lt;<a href=3D"mailto:killghost@msn.com" ta=
rget=3D"_blank">killghost@msn.com</a>&gt;</span> wrote:<br>




<blockquote style=3D"border-left:1px #ccc solid;padding-left:1ex">


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
s@lm-sensors.org" target=3D"_blank">lm-sensors@lm-sensors.org</a><div>




<br>&gt; Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection of=
 NCT6791D<br>&gt; <br></div><div><div>&gt; On Tue, 2 Jul 2013 19:52:30 -070=
0, Guenter Roeck wrote:<br>&gt; &gt; On Tue, Jul 02, 2013 at 09:10:52AM -07=
00, David Bartley wrote:<br>




&gt; &gt; &gt; The value of CR[20]/CR[21] on my board is 0xc8/0x03, and the=
 physical chip<br>&gt; &gt; &gt; itself has &quot;NCT6791D&quot; printed on=
 it.<br>&gt; &gt; <br>&gt; &gt; Hi Jean and David,<br>&gt; &gt; <br>&gt; &g=
t; Nuvoton confirms that 0xc803 is the correct chip ID.<br>




&gt; <br>&gt; OK, I suppose they will fix it in the next version of the dat=
asheet.<br>&gt; Meanwhile you can commit your patch.<br>&gt; <br>&gt; Thank=
s,<br>&gt; -- <br>&gt; Jean Delvare<br>&gt; <br></div></div><div>

&gt; _______________________________________________<br>&gt; lm-sensors mai=
ling list<br>&gt; <a href=3D"mailto:lm-sensors@lm-sensors.org" target=3D"_b=
lank">lm-sensors@lm-sensors.org</a><br>&gt; <a href=3D"http://lists.lm-sens=
ors.org/mailman/listinfo/lm-sensors" target=3D"_blank">http://lists.lm-sens=
ors.org/mailman/listinfo/lm-sensors</a><br>




</div></div> 		 	   		  </div></div>
</blockquote></div><br></div></div></div></div> 		 	   		  </div></div>
</blockquote></div><br></div></div>

--047d7b86f03677191704e0be7b5a--


--===============2492140836923902468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2492140836923902468==--
