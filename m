From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Wed, 01 Dec 2010 02:46:49 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <AANLkTi=K5e3DLyw98xmLNykZ2QXAXfhTdnfLpSRc4+DR@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7083937683542397457=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
To: lm-sensors@vger.kernel.org

--===============7083937683542397457==
Content-Type: multipart/alternative; boundary=90e6ba6e8dde2538a204965051c0

--90e6ba6e8dde2538a204965051c0
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Nov 30, 2010 at 12:30 PM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Phil,
>
> On Tue, 30 Nov 2010 11:05:22 -0800, Phil Pokorny wrote:
> > On Tue, Nov 30, 2010 at 1:17 AM, Jean Delvare <khali@linux-fr.org>
> wrote:
> > > > +             mutex_lock(&data->update_lock);
> > > > +             orig_div = data->fan_div[nr];
> > > > +             data->fan_div[nr] = DIV_FROM_REG(new_div);
> > > > +
> > > > +             if (nr < 4) { /* 0 <= nr < 4 */
> > > > +                     adm1026_write_value(client,
> ADM1026_REG_FAN_DIV_0_3,
> > > > +                                 (DIV_TO_REG(data->fan_div[0]) << 0)
> |
> > > > +                                 (DIV_TO_REG(data->fan_div[1]) << 2)
> |
> > > > +                                 (DIV_TO_REG(data->fan_div[2]) << 4)
> |
> > > > +                                 (DIV_TO_REG(data->fan_div[3]) << 6)
> );
> > > > +             } else { /* 3 < nr < 8 */
> > > > +                     adm1026_write_value(client,
> ADM1026_REG_FAN_DIV_4_7,
> > > > +                                 (DIV_TO_REG(data->fan_div[4]) << 0)
> |
> > > > +                                 (DIV_TO_REG(data->fan_div[5]) << 2)
> |
> > > > +                                 (DIV_TO_REG(data->fan_div[6]) << 4)
> |
> > > > +                                 (DIV_TO_REG(data->fan_div[7]) << 6)
> );
> > > > +             }
> > >
> > > Note: this is horribly inefficient. In my opinion, data->fan_div should
> > > hold split but un-decoded register values. Calling DIV_FROM_REG() is
> > > cheap, calling DIV_TO_REG() is expensive. In fact DIV_TO_REG()
> > > shouldn't exist in the first place, as the conversion should happen in
> > > a single place. Again, this is material for a separate patch.
> >
> > I humbly suggest that you are forgetting something.  With your
> > recommendation, the REG_TO_DIV function would be called many orders of
> > magnitute more times (thousands? millions?) than the DIV_TO_REG function
> > here.  REG_TO_DIV would have to be called every time the fan speed is
> _read_
> > but DIV_TO_REG only needs to be called the one or two times that the
> fan_div
> > is _written_  So while the macros might differ in complexity, the number
> of
> > times they are called swamps any economy gained by changing the fan_div
> from
> > divisor to register value.
>
> You are right on one thing. In all honesty, I had forgotten that
> DIV_FROM_REG() would not only get called for fanX_div sysfs attributes
> but also for fanX_input and fanX_min attributes, which are obviously
> called repeatedly by monitoring applications, so their performance
> matters.
>
> And I agree with you that calling DIV_FROM_REG() in show_fan() and
> show_fan_min() - or even directly in FAN_FROM_REG() - would be costly.
>
> However, we are allowed to be smart (at least I hope so!) Converting
> the divisor register value (0 to 3) into an actual scaling factor (1,
> 2, 4 or 8) to divide or multiply by is inefficient. It's much better to
> use the register value directly to bit-shift the fan input value or
> limit value. Concretely, this means that, if data->fan_div[nr] contains
> a split register value, you don't want to do:
>
> #define FAN_FROM_REG(val, div) ((val) == 0 ? -1 : (val) == 0xff ? 0 : \
>                                1350000 / ((val) * DIV_FROM_REG(div)))
>
> but:
>
> #define FAN_FROM_REG(val, div) ((val) == 0 ? -1 : (val) == 0xff ? 0 : \
>                                1350000 / ((val) << (div)))
>
> And the same holds for FAN_TO_REG(). In the end, DIV_FROM_REG() could
> only be called from show_fan_div(), and DIV_TO_REG only called once
> from set_fan_div() - so we could in fact get rid of both macros.
>

Hmm.  That's creative...

However, the optimization comes at the expense of generality.  This
alternative only allows for power of 2 fan divisors.  This hardware only
supports powers of 2, and probably all other chips are the same.  But other
hardware might support other divisors.  Is there an advantage to having
similar or identical FAN_FROM_REG macros across multiple chips?

Also, it's not necessarily a given that shifts are faster than multiplies.
Integer multipliers can be faster than shifts if a CPU doesn't include a
barrel shifter than can perform arbitrary shifts, but does them with the
equivalent of a loop.  I think the Pentium PRO? had this issue.  It was
mentioned during the AES design bakeoffs that multi-bit shifts could be
expensive on some architectures.  Of course the first SPARC chips were
notable for _not_ having an integer multiply instruction.

In this case, it seems like a multiplication is the appropriate operator for
a "fan divisor" value.  Let the compiler choose the best code.

And your alternative is still clever.


> The code above is clear in and appropriate in my opinion.
>
> The code above is good enough and has the merit of not being too
> intrusive. But I still claim that my counter-proposal would make the code
> cleaner and more efficient... in a future kernel version.
>

I would suggest that such a patch should change the name of "fan_div" to
"fan_div_shift" or "fan_shift" since it's not a divisor.  However, I
recognize that other drivers (Winbond family...) store a "register" shift
value in fan_div...

But I think we've wandered far from the original issue of broken code that
clobbered all the fan divisors when setting any one.

Phil P.

--90e6ba6e8dde2538a204965051c0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Nov 30, 2010 at 12:30 PM, Jean D=
elvare <span dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@li=
nux-fr.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">
Hi Phil,<br>
<div><div></div><div class=3D"h5"><br>
On Tue, 30 Nov 2010 11:05:22 -0800, Phil Pokorny wrote:<br>
&gt; On Tue, Nov 30, 2010 at 1:17 AM, Jean Delvare &lt;<a href=3D"mailto:kh=
ali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&amp;data-&gt;update_lo=
ck);<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 orig_div =3D data-&gt;fan_div[nr];=
<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;fan_div[nr] =3D DIV_FROM_=
REG(new_div);<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (nr &lt; 4) { /* 0 &lt;=3D nr &=
lt; 4 */<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adm1026_write_valu=
e(client, ADM1026_REG_FAN_DIV_0_3,<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (DIV_TO_REG(data-&gt;fan_div[0]) &lt;&lt; 0) |<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (DIV_TO_REG(data-&gt;fan_div[1]) &lt;&lt; 2) |<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (DIV_TO_REG(data-&gt;fan_div[2]) &lt;&lt; 4) |<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (DIV_TO_REG(data-&gt;fan_div[3]) &lt;&lt; 6) );<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 } else { /* 3 &lt; nr &lt; 8 */<br=
>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adm1026_write_valu=
e(client, ADM1026_REG_FAN_DIV_4_7,<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (DIV_TO_REG(data-&gt;fan_div[4]) &lt;&lt; 0) |<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (DIV_TO_REG(data-&gt;fan_div[5]) &lt;&lt; 2) |<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (DIV_TO_REG(data-&gt;fan_div[6]) &lt;&lt; 4) |<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 (DIV_TO_REG(data-&gt;fan_div[7]) &lt;&lt; 6) );<br>
&gt; &gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; &gt;<br>
&gt; &gt; Note: this is horribly inefficient. In my opinion, data-&gt;fan_d=
iv should<br>
&gt; &gt; hold split but un-decoded register values. Calling DIV_FROM_REG()=
 is<br>
&gt; &gt; cheap, calling DIV_TO_REG() is expensive. In fact DIV_TO_REG()<br=
>
&gt; &gt; shouldn&#39;t exist in the first place, as the conversion should =
happen in<br>
&gt; &gt; a single place. Again, this is material for a separate patch.<br>
&gt;<br>
&gt; I humbly suggest that you are forgetting something. =A0With your<br>
&gt; recommendation, the REG_TO_DIV function would be called many orders of=
<br>
&gt; magnitute more times (thousands? millions?) than the DIV_TO_REG functi=
on<br>
&gt; here. =A0REG_TO_DIV would have to be called every time the fan speed i=
s _read_<br>
&gt; but DIV_TO_REG only needs to be called the one or two times that the f=
an_div<br>
&gt; is _written_ =A0So while the macros might differ in complexity, the nu=
mber of<br>
&gt; times they are called swamps any economy gained by changing the fan_di=
v from<br>
&gt; divisor to register value.<br>
<br>
</div></div>You are right on one thing. In all honesty, I had forgotten tha=
t<br>
DIV_FROM_REG() would not only get called for fanX_div sysfs attributes<br>
but also for fanX_input and fanX_min attributes, which are obviously<br>
called repeatedly by monitoring applications, so their performance<br>
matters.<br>
<br>
And I agree with you that calling DIV_FROM_REG() in show_fan() and<br>
show_fan_min() - or even directly in FAN_FROM_REG() - would be costly.<br>
<br>
However, we are allowed to be smart (at least I hope so!) Converting<br>
the divisor register value (0 to 3) into an actual scaling factor (1,<br>
2, 4 or 8) to divide or multiply by is inefficient. It&#39;s much better to=
<br>
use the register value directly to bit-shift the fan input value or<br>
limit value. Concretely, this means that, if data-&gt;fan_div[nr] contains<=
br>
a split register value, you don&#39;t want to do:<br>
<br>
#define FAN_FROM_REG(val, div) ((val) =3D=3D 0 ? -1 : (val) =3D=3D 0xff ? 0=
 : \<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01350000 / (=
(val) * DIV_FROM_REG(div)))<br>
<br>
but:<br>
<br>
#define FAN_FROM_REG(val, div) ((val) =3D=3D 0 ? -1 : (val) =3D=3D 0xff ? 0=
 : \<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01350000 / (=
(val) &lt;&lt; (div)))<br>
<br>
And the same holds for FAN_TO_REG(). In the end, DIV_FROM_REG() could<br>
only be called from show_fan_div(), and DIV_TO_REG only called once<br>
from set_fan_div() - so we could in fact get rid of both macros.<br></block=
quote><div><br>Hmm.=A0 That&#39;s creative...<br><br>However, the optimizat=
ion comes at the expense of generality.=A0 This alternative only allows for=
 power of 2 fan divisors.=A0 This hardware only supports powers of 2, and p=
robably all other chips are the same.=A0 But other hardware might support o=
ther divisors.=A0 Is there an advantage to having similar or identical FAN_=
FROM_REG macros across multiple chips?<br>
<br>Also, it&#39;s not necessarily a given that shifts are faster than mult=
iplies.=A0 Integer multipliers can be faster than shifts if a CPU doesn&#39=
;t include a barrel shifter than can perform arbitrary shifts, but does the=
m with the equivalent of a loop.=A0 I think the Pentium PRO? had this issue=
.=A0 It was mentioned during the AES design bakeoffs that multi-bit shifts =
could be expensive on some architectures.=A0 Of course the first SPARC chip=
s were notable for _not_ having an integer multiply instruction.<br>
<br>In this case, it seems like a multiplication is the appropriate operato=
r for a &quot;fan divisor&quot; value.=A0 Let the compiler choose the best =
code.<br><br>And your alternative is still clever.<br><br><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left:=
 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">
&gt; The code above is clear in and appropriate in my opinion.<br>
<br>
</div>The code above is good enough and has the merit of not being too<br>
intrusive. But I still claim that my counter-proposal would make the code<b=
r>
cleaner and more efficient... in a future kernel version.<br></blockquote><=
div><br>I would suggest that such a patch should change the name of &quot;f=
an_div&quot; to &quot;fan_div_shift&quot; or &quot;fan_shift&quot; since it=
&#39;s not a divisor.=A0 However, I recognize that other drivers (Winbond f=
amily...) store a &quot;register&quot; shift value in fan_div...<br>
<br>But I think we&#39;ve wandered far from the original issue of broken co=
de that clobbered all the fan divisors when setting any one.<br><br>Phil P.=
<br></div></div>

--90e6ba6e8dde2538a204965051c0--


--===============7083937683542397457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7083937683542397457==--
