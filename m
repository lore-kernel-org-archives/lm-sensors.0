From: Vivek Bardia <bardia.vivek@gmail.com>
Date: Wed, 22 Jun 2011 08:57:14 +0000
Subject: Re: [lm-sensors] pmbus driver
Message-Id: <BANLkTinCx2u3YJGS-13g-0EJ6ChMH+Q1AQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2556764017178621684=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20110609131948.GA11436@ericsson.com>
In-Reply-To: <20110609131948.GA11436@ericsson.com>
To: lm-sensors@vger.kernel.org

--===============2556764017178621684==
Content-Type: multipart/alternative; boundary=bcaec51a8bc0bb3df604a648fcbb

--bcaec51a8bc0bb3df604a648fcbb
Content-Type: text/plain; charset=ISO-8859-1

Hi Guenter,

sorry for the delayed reply from my end.

Right now I am under the constraint where I cannot share the datasheet. But
yes, the datasheet is going be out very soon. I shall update u about the
same

Can the pmbus driver be used to set output voltage from another driver in
the kernel space itself. what I understood about the pmbus driver is that it
is meant for monitoring and controlling. at my end if the monitoring is
being done by another entity(voltage regulator) and the controlling only
needs to be done by the PMIC then how do I go about? say I just want to use
VOUT_TRIM command.

is there any sample implementation where I can see how the pmbus api's are
called ?

Regards,
Vivek



On 9 June 2011 18:49, Guenter Roeck <guenter.roeck@ericsson.com> wrote:

> Hi Vivek,
>
> On Thu, Jun 09, 2011 at 07:58:03AM -0400, Vivek Bardia wrote:
> > Hi Guenter,
> >
> > I do not know if this is the right way to ask you about PMBus driver
> > implementation done by you. Do direct me to the right forum if not.
> >
> The lm-sensors mailing list would be the best place to ask, but this will
> do.
> I am copying the list.
>
> > If a PMIC just has one temperature die sensor only, it does not support
> PAGE
> > and PHASE commands, and is just a PMBus based buck controller; then does
> the
> > driver written by you support such a hardware.
> >
> The driver supports BMR45x, which are the same type of controller. So, yes,
> the driver
> should work. Just give it a try. If the generic driver doesn't work, you
> (or I)
> can write a little front-end driver to tell the PMBus core driver which
> registers are
> supported. Worst case the driver may need some patches, but that is
> unlikely.
>
> Do you have a datasheet ?
>
> Thanks,
> Guenter
>
> > some inputs from you can help me decide whether I need to write another
> driver
> > or not. The pmic driver will be used by a voltage regulator driver.
> >
> > Regards,
> > Vivek
> >
> >
>

--bcaec51a8bc0bb3df604a648fcbb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guenter,<div><br></div><div>sorry for the delayed reply from my end.=A0<=
/div><div><br></div><div>Right now I am under the=A0constraint where I cann=
ot share the datasheet. But yes, the datasheet is going be out very soon. I=
 shall update u about the same</div>
<div><br></div><div>Can the pmbus driver be used to set output voltage from=
 another driver in the kernel space itself. what I understood about the pmb=
us driver is that it is meant for monitoring and controlling. at my end if =
the monitoring is being done by another entity(voltage regulator) and the c=
ontrolling only needs to be done by the PMIC then how do I go about? say I =
just want to use VOUT_TRIM command.=A0</div>
<div><br></div><div>is there any sample implementation where I can see how =
the pmbus api&#39;s are called ?</div><div><br></div><div>Regards,<br>Vivek=
</div><div><br></div><div><br></div><div><br><div class=3D"gmail_quote">On =
9 June 2011 18:49, Guenter Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:gu=
enter.roeck@ericsson.com">guenter.roeck@ericsson.com</a>&gt;</span> wrote:<=
br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;">Hi Vivek,<br>
<div class=3D"im"><br>
On Thu, Jun 09, 2011 at 07:58:03AM -0400, Vivek Bardia wrote:<br>
&gt; Hi Guenter,<br>
&gt;<br>
&gt; I do not know if this is the right way to ask you about PMBus driver<b=
r>
&gt; implementation done by you. Do direct me to the right forum if not.<br=
>
&gt;<br>
</div>The lm-sensors mailing list would be the best place to ask, but this =
will do.<br>
I am copying the list.<br>
<div class=3D"im"><br>
&gt; If a PMIC just has one temperature die sensor only, it does not suppor=
t PAGE<br>
&gt; and PHASE commands, and is just a PMBus based buck controller; then do=
es the<br>
&gt; driver written by you support such a hardware.<br>
&gt;<br>
</div>The driver supports BMR45x, which are the same type of controller. So=
, yes, the driver<br>
should work. Just give it a try. If the generic driver doesn&#39;t work, yo=
u (or I)<br>
can write a little front-end driver to tell the PMBus core driver which reg=
isters are<br>
supported. Worst case the driver may need some patches, but that is unlikel=
y.<br>
<br>
Do you have a datasheet ?<br>
<br>
Thanks,<br>
<font color=3D"#888888">Guenter<br>
</font><div><div></div><div class=3D"h5"><br>
&gt; some inputs from you can help me decide whether I need to write anothe=
r driver<br>
&gt; or not. The pmic driver will be used by a voltage regulator driver.<br=
>
&gt;<br>
&gt; Regards,<br>
&gt; Vivek<br>
&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--bcaec51a8bc0bb3df604a648fcbb--


--===============2556764017178621684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2556764017178621684==--
