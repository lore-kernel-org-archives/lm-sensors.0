From: David Hubbard <david.c.hubbard@gmail.com>
Date: Thu, 13 Dec 2012 21:27:57 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <CAC-0EqiiCKDWuJrHV44c4gaEfnQJqaJLV1y9W7ZdypWXm3hKqg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7071518114582815644=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7071518114582815644==
Content-Type: multipart/alternative; boundary=20cf30334b05af9a3904d0c2963b

--20cf30334b05af9a3904d0c2963b
Content-Type: text/plain; charset=ISO-8859-1

Hi Guenter,

On Thu, Dec 13, 2012 at 9:07 AM, Guenter Roeck <groeck-dsl@sbcglobal.net>wrote:

> On Thu, Dec 13, 2012 at 01:00:30AM -0700, David Hubbard wrote:
> > I'd like to send the same patch again but add signed-off-by this time :)
> I
> > apologize.
> >
> > * * * * *
> >
> > Add experimental support for the it8603e chip (Asus f2a85-m motherboard)
> > Write only tested for pwmN and pwmN_enable.
> > Read tested, but the following appear broken:
> >   alarms
> >   fanN_alarm
> >   inN_alarm
> >   inN_max
> >   inN_min
> >   intrusionN_alarm
> >   pwmN_auto_channels_temp
> >   pwmN_freq
>
> I don't think it is a good idea to report attributes which "appear to be
> broken". At least for the voltage limits and the alarms it should be
> relatively
> easy to find out if they work/don't work. Whatever doesn't work should not
> be
> there.
>

They don't work but I don't know why. Until we have a datasheet, I'd like
to leave them in the *experimental* driver and wait for a second opinion
from someone who actually has the chip.


>
> >   temp3_input (there is no 3rd analog temp input to the chip)
> >
> Other IT87xx chips report the AMDSTI/PCH temperature as one of the inputs.
> This
> is usually configurable.
>
>
Ok, fine with me.

Another question is to what extend we can depend on the logic in
> it87_find() to
> detect enabled chip features. It might make more sense to create another
> if case
> in that function to handle the IT8603 separately.
>

it87_find() seems to have identified the correct features of the IT8603. I
don't understand your concern with the way it is currently working.

Regards,
David

--20cf30334b05af9a3904d0c2963b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guenter,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Thu, Dec 13, 2012 at 9:07 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a href=
=3D"mailto:groeck-dsl@sbcglobal.net" target=3D"_blank">groeck-dsl@sbcglobal=
.net</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Thu, Dec 13, 2012 at 01=
:00:30AM -0700, David Hubbard wrote:<br>
&gt; I&#39;d like to send the same patch again but add signed-off-by this t=
ime :) I<br>
&gt; apologize.<br>
&gt;<br>
&gt; * * * * *<br>
&gt;<br>
&gt; Add experimental support for the it8603e chip (Asus f2a85-m motherboar=
d)<br>
&gt; Write only tested for pwmN and pwmN_enable.<br>
&gt; Read tested, but the following appear broken:<br>
&gt; =A0 alarms<br>
&gt; =A0 fanN_alarm<br>
&gt; =A0 inN_alarm<br>
&gt; =A0 inN_max<br>
&gt; =A0 inN_min<br>
&gt; =A0 intrusionN_alarm<br>
&gt; =A0 pwmN_auto_channels_temp<br>
&gt; =A0 pwmN_freq<br>
<br>
</div>I don&#39;t think it is a good idea to report attributes which &quot;=
appear to be<br>
broken&quot;. At least for the voltage limits and the alarms it should be r=
elatively<br>
easy to find out if they work/don&#39;t work. Whatever doesn&#39;t work sho=
uld not be<br>
there.<br></blockquote><div><br>They don&#39;t work but I don&#39;t know wh=
y. Until we have a datasheet, I&#39;d like to leave them in the *experiment=
al* driver and wait for a second opinion from someone who actually has the =
chip.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im"><br>
&gt; =A0 temp3_input (there is no 3rd analog temp input to the chip)<br>
&gt;<br>
</div>Other IT87xx chips report the AMDSTI/PCH temperature as one of the in=
puts. This<br>
is usually configurable.<br>
<br></blockquote><div><br>Ok, fine with me.<br><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
Another question is to what extend we can depend on the logic in it87_find(=
) to<br>
detect enabled chip features. It might make more sense to create another if=
 case<br>
in that function to handle the IT8603 separately.<br></blockquote><div><br>=
it87_find() seems to have identified the correct features of the IT8603. I =
don&#39;t understand your concern with the way it is currently working.<br>
<br>Regards,<br>David<br><span class=3D"HOEnZb"></span></div></div></div>

--20cf30334b05af9a3904d0c2963b--


--===============7071518114582815644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7071518114582815644==--
